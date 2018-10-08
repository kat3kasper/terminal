require 'rails_helper'

feature 'Jobs' do
  let!(:rails_competence) { create :competence, value: 'Rails' }
  let!(:competencies) { create_list :competence, 5 }

  context 'when the company is not vetted' do
    let(:benefit_1) { create :benefit, value: 'Office Dogs' }
    let(:benefit_2) { create :benefit, value: '30+ Days Parental Leave' }
    let(:benefits) { [benefit_1, benefit_2] }
    let!(:other_benefit) { create :benefit, value: 'foo' }

    let(:culture_1) { create :culture, value: 'No Cubicles' }
    let(:culture_2) { create :culture, value: 'company outings' }
    let(:cultures) { [culture_1, culture_2] }
    let!(:other_culture) { create :culture, value: 'bar' }

    let(:company) { create :company, :active, benefits: benefits, cultures: cultures }
    let(:recruiter) { create :recruiter, company: company }
    let(:job_attrs) { build :job }
    let!(:rails_competence) { create :competence, value: 'Rails' }
    let!(:competencies) { create_list :competence, 5 }

    before do
      sign_in recruiter
    end

    scenario 'adds a new job (first step)' do
      click_on 'Add a new job'

      fill_in 'Title', with: job_attrs.title
      fill_in 'Description', with: job_attrs.description
      select job_attrs.employment_type, from: 'Employment type'
      check 'Remote'
      fill_in 'City', with: job_attrs.city
      fill_in 'State', with: job_attrs.state
      fill_in 'Country', with: job_attrs.country
      click_on 'Continue'

      expect(page).to have_content 'Please choose up to 2 skills'
      new_job = Job.find_by title: job_attrs.title
      expect(new_job.company).to eq company
      expect(new_job.employment_type).to eq job_attrs.employment_type
      expect(new_job.benefits).to eq company.benefits
      expect(new_job.cultures).to eq company.cultures
      expect(new_job.skills_array).to eq []
    end

    scenario 'adds a new job (last step)', js: true do
      new_job = create :job, company: company, skills_array: []

      visit skills_job_path new_job
      expect(page).to have_content 'Please choose up to 2 skills'

      fill_in 'Select a skill...', with: 'Rails'
      find('.dropdown-item', match: :first).click
      # unable to select different levels within the test
      click_on 'Add to your skills'

      fill_in 'Select a skill...', with: competencies.first.value
      find('.dropdown-item', match: :first).click
      click_on 'Add to your skills'

      click_on 'Publish'

      expect(page).to have_content new_job.title.upcase
      expect(page).to have_content 'Rails 1'
      expect(new_job.reload.skills_array).to match_array ['Rails/1', "#{competencies.first.value}/1"]
    end

    context 'with active jobs' do
      let!(:jobs) { create_list :job, 3, company: company }
      let!(:job_to_change) { create :job, company: company }

      scenario 'can deactivate a job' do
        visit dashboard_companies_path
        within('div.matched-job', text: job_to_change.title) { click_on 'Unpublish' }

        expect(job_to_change.reload.active).to eq false
        within('#nav-profile') do
          expect(page).to_not have_content job_to_change.title
        end
      end

      scenario 'can delete a job' do
        visit dashboard_companies_path
        within('div.matched-job', text: job_to_change.title) { click_on 'delete-job' }

        within('#nav-profile') do
          expect(page).to_not have_content job_to_change.title
        end
      end
    end
  end

  context 'when a company is vetted' do
    let(:vetted_company) { create :company, vetted: true }
    let(:recruiter) { create :recruiter, company: vetted_company }
    let!(:job) { create :job, company: vetted_company }
    let!(:inactive_job) { create :job, company: vetted_company, active: false }

    before do
      sign_in recruiter
    end

    scenario 'can deactivate a job from the index' do
      visit dashboard_companies_path
      within('div.matched-job', text: job.title) { click_on 'Unpublish' }

      expect(job.reload.active).to eq false
      within('#nav-profile') do
        expect(page).to_not have_content job.title
      end
    end

    scenario 'inactive jobs do not show by default on index' do
      visit dashboard_companies_path
      within('#nav-profile') do
        expect(page).to_not have_content inactive_job.title
      end

      click_on 'Inactive Jobs'
      within('#nav-inactive') do
        expect(page).to have_content inactive_job.title
      end
    end
  end

  context 'when a company is inactive' do
    let(:inactive_company) { create :company }
    let(:recruiter) { create :recruiter, company: inactive_company }

    before do
      sign_in recruiter
    end

    scenario 'cannot activate a job' do
      expect(page).to have_content 'You are no longer a member'
      expect(page).to have_link 'here', href: new_subscriber_path
    end
  end
end
