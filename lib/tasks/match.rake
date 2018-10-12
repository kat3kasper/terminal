namespace :match do
  desc "Check for new job matches & send notifications to job seekers"
  task notification: :environment do
    Developer.check_for_new_matches
  end

end
