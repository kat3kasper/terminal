require 'rails_helper'

feature 'Recruiter sign up' do
  let(:recruiter_country) { 'US' }
  let!(:cultures) do
      [
        create(:culture, value: 'This is a culture.'),
        create(:culture, value: 'This is also a culture.')
      ]
  end
  before do

    stub_request(:get, /ipinfo.io/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: recruiter_country, headers: {})
  end

  scenario 'a new recruiter can sign up and create a company profile' do
    clear_emails
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
    click_on 'Confirm'

    expect(Company.last.cultures.length).to eq(cultures.length)

    open_email('colin@example.com')
    current_email.click_link 'CLICK HERE'
    expect(page).to have_content 'Payment method'
  end
end
