class DeveloperMailer < ApplicationMailer
  default :from => 'info@findmyflock.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address

  def new_match_advise(developer, jobs)
    @developer = developer
    @jobs = jobs
    mail( :to => @developer.email,
    :subject => 'You Have A New Job Match!' )
  end

  def application_opened(application)
    @job = application.match.job
    @developer = application.match.developer
    @company = @job.company
    mail( :to => @developer.email,
    :subject => 'Application Status Update' )
  end

end
