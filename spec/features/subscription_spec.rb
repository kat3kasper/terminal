require 'rails_helper'

feature 'Subscriptions' do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let!(:plan) { create :plan, :jobs_1 }

  before do
    StripeMock.start
    stripe_helper.create_plan id: plan.stripe_id

    Stripe::Coupon.create(
      percent_off: 25,
      duration: 'repeating',
      duration_in_months: 3,
      id: "fmf-1"
    )

  end

  after { StripeMock.stop }

  scenario 'sign up link is reachable from home page' do
    visit root_path
    click_on 'Companies'
    expect(page).to have_link 'Sign up', href: new_recruiter_registration_path
  end

  scenario 'a recruiter signs up' do
    new_recruiter = build :recruiter

    visit new_recruiter_registration_path

    fill_in 'Email', with: new_recruiter.email
    fill_in 'Password', with: new_recruiter.password
    fill_in 'Password confirmation', with: new_recruiter.password
    click_on 'Sign up'

    open_email new_recruiter.email # open the email confirmation email for later

    fill_in 'Name', with: new_recruiter.company.name
    fill_in 'Industry', with: new_recruiter.company.industry
    fill_in 'Url', with: new_recruiter.company.url
    check Benefit.first.value
    check Culture.first.value
    click_on 'Confirm'

    card = stripe_helper.generate_card_token
    find('label', text: '1 Job').click
    find('#stripeToken', visible: false).set card
    click_on 'Submit Payment'

    expect(page).to have_link "Add a new job"

    # Circle back around and confirm the email address
    expect(current_email).to have_content 'Welcome to the Find My Flock community'
    current_email.click_link 'CLICK HERE'
    recruiter = Recruiter.find_by email: new_recruiter.email
    expect(recruiter.company.name).to eq new_recruiter.company.name
    expect(recruiter.confirmed_at).to be_present
    expect(recruiter.company.is_active?).to be true

    open_email new_recruiter.email
    expect(current_email).to have_content "Congratulations on adding #{new_recruiter.company.name}"
    current_email.click_link 'CLICK HERE'
    expect(page).to have_content 'Create your job'
  end

  scenario 'a recruiter signs up with an invalid coupon code' do
    new_recruiter = build :recruiter

    visit new_recruiter_registration_path

    fill_in 'Email', with: new_recruiter.email
    fill_in 'Password', with: new_recruiter.password
    fill_in 'Password confirmation', with: new_recruiter.password
    click_on 'Sign up'

    fill_in 'Name', with: new_recruiter.company.name
    fill_in 'Industry', with: new_recruiter.company.industry
    fill_in 'Url', with: new_recruiter.company.url
    check Benefit.first.value
    check Culture.first.value
    click_on 'Confirm'

    card = stripe_helper.generate_card_token
    find('label', text: '1 Job').click
    find('#stripeToken', visible: false).set card
    fill_in 'Coupon Code', with: "FakeCoupon"
    click_on 'Submit Payment'

    expect(page).to_not have_link "Add a new job"
    expect(page).to have_content "Payment method"
  end

  scenario 'a recruiter signs up with an valid coupon code' do
    new_recruiter = build :recruiter

    visit new_recruiter_registration_path

    fill_in 'Email', with: new_recruiter.email
    fill_in 'Password', with: new_recruiter.password
    fill_in 'Password confirmation', with: new_recruiter.password
    click_on 'Sign up'

    fill_in 'Name', with: new_recruiter.company.name
    fill_in 'Industry', with: new_recruiter.company.industry
    fill_in 'Url', with: new_recruiter.company.url
    check Benefit.first.value
    check Culture.first.value
    click_on 'Confirm'

    card = stripe_helper.generate_card_token
    find('label', text: '1 Job').click
    find('#stripeToken', visible: false).set card
    fill_in 'Coupon Code', with: "FMF1"
    click_on 'Submit Payment'

    expect(page).to have_link "Add a new job"
  end

  scenario 'a recruiter with incomplete signup gets redirected to new company' do
    new_recruiter = build :recruiter

    visit new_recruiter_registration_path

    fill_in 'Email', with: new_recruiter.email
    fill_in 'Password', with: new_recruiter.password
    fill_in 'Password confirmation', with: new_recruiter.password
    click_on 'Sign up'

    visit dashboard_companies_path
    expect(page).to have_content "Create your company"
  end

  scenario 'a recruiter with incomplete signup gets redirected to subscribe' do
    new_recruiter = build :recruiter
    visit new_recruiter_registration_path
    fill_in 'Email', with: new_recruiter.email
    fill_in 'Password', with: new_recruiter.password
    fill_in 'Password confirmation', with: new_recruiter.password
    click_on 'Sign up'
    fill_in 'Name', with: new_recruiter.company.name
    fill_in 'Industry', with: new_recruiter.company.industry
    fill_in 'Url', with: new_recruiter.company.url
    check Benefit.first.value
    check Culture.first.value
    click_on 'Confirm'

    visit new_job_path
    expect(page).to have_content "Payment method"
  end

  context 'when a recruiter has a subscription' do
    let(:company) { create :company, :active }
    let(:recruiter) { create :recruiter, company: company }

    before do
      plan = stripe_helper.create_plan id: company.subscriber.plan.stripe_id
      card = stripe_helper.generate_card_token
      customer = Stripe::Customer.create source: card
      @subscription = Stripe::Subscription.create customer: customer.id, items: [{ plan: plan.id }]
      company.subscriber.update stripe_subscription_id: @subscription.id

      sign_in recruiter
    end

    scenario 'recruiter cancels a subscription' do
      visit subscribers_path
      expect(page).to have_content "Manage my subscription"

      click_on "Cancel my subscription"

      stripe_subscription = Stripe::Subscription.retrieve @subscription.id
      expect(stripe_subscription.cancel_at_period_end).to be true

      expect(page).to have_content "Status:\ncanceled"
      canceled_time = Time.at(stripe_subscription.current_period_end)
      expect(page).to have_content "Active Until:\n#{canceled_time.in_time_zone.strftime('%B %-d %Y')}"
    end
  end
end
