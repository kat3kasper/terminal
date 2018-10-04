require 'rails_helper'

feature 'Developer dashboard' do
  let(:developer) { create :developer, :with_profile, :remote }

  let!(:active_company) { create :company, vetted: true }
  let!(:active_job) { create :job, :remote, company_id: active_company.id }
  let!(:no_benefits_job) { create :job, :remote, company_id: active_company.id, benefits: [] }

  let!(:inactive_company) { create :company }
  let!(:inactive_job) { create :job, :remote, company_id: inactive_company.id }

  before { sign_in developer }

  scenario 'does not see jobs for inactive companies' do
    expect(page).to have_content active_job.title
    expect(page).to_not have_content inactive_job.title
  end

  scenario 'can filter by benefits', js: true do
    click_on 'Benefits'
    check active_job.benefits.first.value
    expect(page).to_not have_content no_benefits_job.title.upcase
    expect(page).to have_content active_job.title.upcase
  end
end
