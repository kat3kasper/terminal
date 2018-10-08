require 'rails_helper'

feature 'Recruiter sign up' do
  let(:recruiter_country) { 'US' }
  let!(:cultures) do
    [
      create(:culture, value: 'This is a culture.'),
      create(:culture, value: 'This is also a culture.')
    ]
  end
  let!(:benefits) do
    [
      create(:benefit, value: 'This is a benefit.'),
      create(:benefit, value: 'This is another benefit.')
    ]
  end
  before do
    stub_request(:get, /ipinfo.io/)
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: recruiter_country, headers: {})
  end

  scenario 'a new recruiter can sign up and create a company profile' do
    visit root_path
    click_on 'Join'
    click_on 'Sign up here'
    expect(page).to have_content 'Create your recruiter account'
    fill_in 'Email', with: 'colin@example.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Password confirmation', with: 'Password123'
    click_on 'Sign up'

    open_email('colin@example.com')
    current_email.click_link 'CLICK HERE'
    expect(page).to have_content 'Create your company'
    fill_in 'Name', with: 'My Example Company'
    fill_in 'Industry', with: 'General Manufacturing'
    fill_in 'Url', with: 'http://example.com/'
    cultures.each { |c| check c.value }
    benefits.each { |b| check b.value }
    click_on 'Confirm'

    expect(Company.last.cultures.length).to eq cultures.length
    expect(Company.last.benefits.length).to eq benefits.length

    open_email('colin@example.com')
    current_email.click_link 'CLICK HERE'
    expect(page).to have_content 'Payment method'
  end

  scenario 'requires benefits and cultures when creating a company profile' do
    visit root_path
    click_on 'Join'
    click_on 'Sign up here'
    fill_in 'Email', with: 'colin@example.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Password confirmation', with: 'Password123'
    click_on 'Sign up'

    expect(page).to have_content 'Create your company'
    fill_in 'Name', with: 'My Example Company'
    fill_in 'Industry', with: 'General Manufacturing'
    fill_in 'Url', with: 'http://example.com/'

    click_on 'Confirm'

    expect(page).to have_content "Benefits can't be blank"
    expect(page).to have_content "Cultures can't be blank"
  end

  scenario 'requires benefits and cultures when editing a company profile' do
    recruiter = create :recruiter
    sign_in recruiter

    visit edit_company_path recruiter.company

    expect(page).to have_content 'Edit your company'
    recruiter.company.cultures.each { |c| uncheck c.value }
    recruiter.company.benefits.each { |b| uncheck b.value }
    click_on 'Confirm'

    expect(page).to have_content 'Edit your company'
    expect(page).to have_content "Benefits can't be blank"
    expect(page).to have_content "Cultures can't be blank"
  end
end
