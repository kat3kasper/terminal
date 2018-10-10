require 'rails_helper'

feature "Recruiter applications" do
  let(:developer) { create :developer, :with_profile, :remote }
  let(:developer_message) { 'A message' }
  let(:recruiter_message) { 'Hello you' }

  let(:company) { create :company, vetted: true }
  let!(:recruiter) { create :recruiter, company: company }
  let!(:active_job) { create :job, :remote, company: company }

  context 'with a pending application' do
    before do
      sign_in developer
      clear_emails

      within('.matched-job', text: active_job.title) { click_on 'Details' }
      fill_in 'application_message', with: developer_message
      click_on 'Send application'

      sign_in recruiter
    end

    scenario "receives an email" do
      open_email recruiter.email
      expect(current_email).to have_content 'You have just received an application'
      expect(current_email).to have_content developer.full_name
      expect(current_email).to have_content developer_message

      current_email.click_link 'Respond Now'

      expect(page).to have_content developer.full_name
      expect(page).to have_content developer_message
      expect(page).to have_link 'Download'
    end

    scenario "views application from dashboard" do
      click_on "Applications"
      within('.matched-job', text: developer.full_name) do
        expect(page).to have_content "Current state\nNew"
        click_on "View"
      end

      expect(page).to have_content developer_message
      expect(page).to have_content "Current state\nOpened"
    end

    scenario "contacts developer" do
      within('.matched-job', text: developer.full_name) { click_on "View" }
      clear_emails

      fill_in "Type your personal message for the candidate", with: recruiter_message
      click_on 'Send email'
      expect(page).to have_content "Current state\nContacted"

      open_email developer.email
      expect(current_email).to have_content recruiter_message
      expect(current_email.from).to eq [recruiter.email]
    end

    scenario "rejects developer" do
      within('.matched-job', text: developer.full_name) { click_on "View" }
      clear_emails

      click_on 'Reject application'
      expect(page).to_not have_content developer.full_name

      open_email developer.email
      expect(current_email).to have_content 'rejected'
    end
  end
end
