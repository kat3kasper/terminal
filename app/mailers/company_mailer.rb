class CompanyMailer < ApplicationMailer
  def welcome_company(company_id)
    @company = Company.find(company_id)
    @address = @company.recruiters.first.email
    mail(
      from: 'info@findmyflock.com',
      to: @address,
      subject: 'New Company Added'
    )
  end

  def new_application_advise(company_id, match_id, developer_id)
    @developer = Developer.find(developer_id)
    @match = Match.find(match_id)
    @job = @match.job
    @application = @match.application
    @mail_addresses = Company.find(company_id).recruiters_mail.join('')
    mail(
      to: @mail_addresses,
      subject: 'New Application Received'
    )
  end

  def cancelled_application_advise(application_id, developer_id, job_id)
    address = Application.find(application_id).recruiters_mail.join('')
    @developer = Developer.find(developer_id)
    @job = Job.find(job_id)
    mail(
      from: 'info@findmyflock.com',
      to: address,
      subject: 'An application to your job has been cancelled'
    )
  end

  def contact_developer(message, job_id, developer_id, recruiter_id)
    @message = message
    @developer = Developer.find(developer_id)
    @job = Job.find(job_id)
    @mail_address = Recruiter.find(recruiter_id).email
    mail(
      from: @mail_address,
      to: @developer.email,
      subject: 'A Message From Your Recruiter'
    )
  end

  def application_review_reminder(application_ids_array)
    @applications_array = []
    addresses = []
    application_ids_array.each do |id|
      app = Application.find(id)
      @applications_array << app
      addresses << app.recruiters_mail
    end
    addresses = addresses.uniq.join(',')
    mail(
      from: 'info@findmyflock.com',
      to: addresses,
      subject: 'An application is still waiting for your review!'
    )
  end
end
