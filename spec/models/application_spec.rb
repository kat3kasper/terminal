require 'rails_helper'

describe Application do
  let(:developer) { create :developer, :with_profile, :remote }

  let(:company_1) { create :company, vetted: true }
  let(:company_2) { create :company, vetted: true }
  let!(:recruiter_1) { create :recruiter, company: company_1 }
  let!(:recruiter_2) { create :recruiter, company: company_2 }
  let(:job_1) { create :job, company: company_1 }
  let(:job_2) { create :job, company: company_2 }
  let(:match_1) { create :match, job: job_1, developer: developer}
  let(:match_2) { create :match, job: job_2, developer: developer}


  context 'last mail is more than 7 days' do
    context 'status is pending or opened' do
      let(:pending_application_1) {
                                  create :application,
                                  match: match_1,
                                  status: 'pending',
                                  last_mail_sent: 10.days.ago
                                }
      let(:pending_application_2) {
                                  create :application,
                                  match: match_2,
                                  status: 'pending',
                                  last_mail_sent: 10.days.ago
                                }
      let(:opened_application) {
                                 create :application,
                                 match: match_1,
                                 status: 'opened',
                                 last_mail_sent: 10.days.ago
                               }

      it 'sends a reminder to recruiters one company at a time' do
        expect(CompanyMailer).to receive(:application_review_reminder)
                             .with([pending_application_1.id, opened_application.id])
                             .and_call_original
        expect(CompanyMailer).to receive(:application_review_reminder)
                             .with([pending_application_2.id])
                             .and_call_original
        Application.remind_companies_to_review
      end
    end

    context 'status is contacted or rejected' do
      let(:contacted_application) {
                                    create :application,
                                    match: match_1,
                                    status: 'contacted',
                                    last_mail_sent: 10.days.ago
                                  }
      let(:rejected_application) {
                                   create :application,
                                   match: match_1,
                                   status: 'rejected',
                                   last_mail_sent: 10.days.ago
                                 }

      it 'does not send a reminder to the recruiter' do
        expect(CompanyMailer).to_not receive(:application_review_reminder)
        Application.remind_companies_to_review
      end
    end
  end

  context 'last mail is less than 7 days' do
    context 'application is contacted or rejected' do
      let(:contacted_application) {
                                    create :application,
                                    match: match_1,
                                    status: 'contacted',
                                    last_mail_sent: 2.days.ago
                                  }
      let(:rejected_application) {
                                   create :application,
                                   match: match_1,
                                   status: 'rejected',
                                   last_mail_sent: 2.days.ago
                                 }

      it 'does not send a reminder to the recruiter' do
        expect(CompanyMailer).to_not receive(:application_review_reminder)
        Application.remind_companies_to_review
      end
    end

    context 'application is pending or opened' do
      let(:pending_application) {
                                  create :application,
                                  match: match_1,
                                  status: 'pending',
                                  last_mail_sent: 2.days.ago
                                }
      let(:opened_application) {
                                 create :application,
                                 match: match_1,
                                 status: 'pending',
                                 last_mail_sent: 2.days.ago
                               }

      it 'does not send a reminder to the recruiter' do
        expect(CompanyMailer).to_not receive(:application_review_reminder)
        Application.remind_companies_to_review
      end
    end
  end
end
