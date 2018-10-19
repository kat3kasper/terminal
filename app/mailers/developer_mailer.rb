class DeveloperMailer < ApplicationMailer
  def new_match_advise(developer_id, jobs)
    @developer = Developer.find(developer_id)
    @jobs = jobs
    mail( to: @developer.email, subject: 'You Have A New Job Match!' )
  end

  def application_opened(application_id)
    application = Application.find(application_id)
    @job = application.match.job
    @developer = application.match.developer
    @company = @job.company
    mail( to: @developer.email, subject: 'Application Status Update' )
  end

  def application_rejected(application_id)
    application = Application.find(application_id)
    @job = application.match.job
    @developer = application.match.developer
    @company = @job.company
    mail( to: @developer.email, subject: 'Application Status Update' )
  end

  def unapplied_matches_reminder(matches_ids_array)
    @matches_array = []
    addresses = []
    matches_ids_array.each do |id|
      match = Match.find(id)
      @matches_array << match
      addresses << app.developer.email
    end
    addresses = addresses.uniq.join(',')
    mail(
      from: 'info@findmyflock.com',
      to: addresses,
      subject: 'There are opportunities you might want to consider!'
    )
  end
end
