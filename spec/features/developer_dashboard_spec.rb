require 'rails_helper'

feature 'Developer dashboard' do
  let(:developer) { create :developer, :with_profile, :remote }

  let(:active_company) { create :company, vetted: true }
  let!(:active_job) { create :job, :remote, company_id: active_company.id }

  let(:benefit) { create :benefit, value: 'other benefit' }
  let(:culture) { create :culture, value: 'not my culture' }
  let(:other_company) { create :company, vetted: true, benefits: [benefit], cultures: [culture] }
  let!(:other_job) { create :job, :remote, company_id: other_company.id }

  let(:inactive_company) { create :company }
  let!(:inactive_job) { create :job, :remote, company_id: inactive_company.id }

  let(:all_benefits) { Benefit.all }
  let(:company_with_all_benefits) { create :company, vetted: true, benefits: all_benefits }
  let!(:job_with_all_benefits) { create :job, :remote, company_id: company_with_all_benefits.id }

  let(:all_cultures) { Culture.all }
  let(:all_company) { create :company, vetted: true, cultures: all_cultures, benefits: all_benefits }
  let!(:job_with_all) { create :job, :remote, company_id: all_company.id }

  before { sign_in developer }

  scenario 'does not see jobs for inactive companies' do
    expect(page).to have_content active_job.title
    expect(page).to_not have_content inactive_job.title
  end

  scenario 'can filter by benefits', js: true do
    click_on 'Benefits'
    check active_company.benefits.first.value

    expect(page).to_not have_content other_job.title.upcase
    expect(page).to have_content active_job.title.upcase
    expect(page).to_not have_content inactive_job.title.upcase
  end

  scenario 'can filter by multiple benefits', js: true do
    click_on 'Benefits'
    check active_company.benefits.first.value
    check other_company.benefits.first.value

    expect(page).to have_content job_with_all_benefits.title.upcase
    expect(page).to_not have_content other_job.title.upcase
    expect(page).to_not have_content active_job.title.upcase
    expect(page).to_not have_content inactive_job.title.upcase
  end

  scenario 'can filter by cultures', js: true do
    click_on 'Cultures'
    check active_company.cultures.first.value

    expect(page).to_not have_content other_job.title.upcase
    expect(page).to have_content active_job.title.upcase
    expect(page).to_not have_content inactive_job.title.upcase
  end

  scenario 'can filter by benefits and cultures', js: true do
    click_on 'Benefits'
    check other_company.benefits.first.value
    click_on 'Cultures'
    sleep 2
    check active_company.cultures.first.value

    expect(page).to have_content job_with_all.title.upcase
    expect(page).to_not have_content job_with_all_benefits.title.upcase
    expect(page).to_not have_content other_job.title.upcase
    expect(page).to_not have_content active_job.title.upcase
    expect(page).to_not have_content inactive_job.title.upcase
  end
end
