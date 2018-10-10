namespace :application do
  desc "Check if need to send an application reminder to recruiter"
  task reminder: :environment do
    Application.remind_companies_to_review
  end
end
