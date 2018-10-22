require 'rails_helper'

describe Match do
  context 'has not sent a reminder' do
    let(:developer) { create :developer, :with_profile }

    let(:company_1) { create :company, vetted: true }
    let(:company_2) { create :company, vetted: true }
    let(:job_1) { create :job, company: company_1 }
    let(:job_2) { create :job, company: company_2 }

    context 'does not have an application' do
      let(:match_1) { create :match, :expired, job: job_1, developer: developer }

      it 'sends a reminder' do
        expect(DeveloperMailer).to receive(:unapplied_matches_reminder)
        Match.remind_job_seekers_to_apply
      end
    end

    context 'have an application' do
      let(:application) {
                          create :application,
                          match: match_1
                        }
      it 'does not send a reminder' do
        expect(DeveloperMailer).to_not receive(:unapplied_matches_reminder)
        Match.remind_job_seekers_to_apply
      end
    end
  end
end
