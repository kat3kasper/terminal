class ApplicationsController < ApplicationController
  before_action :authenticate_developer!, only: [:new, :create]
  before_action :authenticate_recruiter!, only: [:show, :contact, :reject]
  before_action :set_application, only: [:show, :contact]
  before_action :set_job, only: [:new, :create, :reject]
  before_action :set_match, only: [:new, :create]

  def show
    application_id = @application.id
    DeveloperMailer.application_opened(application_id).deliver if @application.pending?
    set_opened(@application)
  end

  def new
    @application = Application.where(match: @match).first_or_initialize
    @developer = current_developer
    @is_posted = application_is_posted? @match
    @applications_sent = applications_sent_today
    @recruiter = @job.vetted ? 'Find My Flock' : @job.company.name
  end

  def create
    application = Application.new(application_params)
    application.match = @match
    developer = @match.developer
    developer.update(developer_params) if developer_params.try(:[], :resumes)
    company = @match.job.company
    company_id = company.id
    match_id = @match.id
    developer_id = @match.developer.id

    if !developer.resumes.attached?
      upload_resume = 'You need to upload a resume in order to apply.'
      return redirect_to new_job_application_path(@job), alert: upload_resume
    end

    respond_to do |format|
      if application.save
        format.html { redirect_to new_job_application_path(@match.job) }
        CompanyMailer.new_application_advise(company_id, match_id, developer_id).deliver
        application.update_attribute(:last_mail_sent, Time.now)
      else
        format.html do
          render :new, alert: 'Something went wrong please try again.'
        end
      end
    end
  end

  def destroy
    application = Application.find params[:id]
    if application.status != "rejected" && application.destroy
      redirect_to dashboard_developers_path, notice: 'Application was successfully deleted.'
    else
      redirect_to dashboard_developers_path, notice: 'There was an error deleting your application'
    end
  end

  def contact
    message = params[:private_message]
    job_id = @job.id
    developer_id = @developer.id
    if !message.empty?
      recruiter_id = current_recruiter.id
      CompanyMailer.contact_developer(message, job_id, developer_id, recruiter_id).deliver
      @application.contacted!
      redirect_to job_application_path(@job), notice: "We've sent an email to the candidate."
    end
  end

  def reject
    application = Application.find params[:id]
    application.rejected!
    DeveloperMailer.application_rejected(application.id).deliver if application.rejected?
    redirect_to dashboard_companies_path, notice: "We've sent an email to the candidate."
  end

  private

  def applications_sent_today
    count = 0
    matches = Match.where(developer: current_developer)
    matches.each do |match|
      application = Application.where(match: match, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      count += 1 if !application.empty?
    end
    count
  end

  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_application
    @application = Application.find(params[:id])
    @job = @application.job
    @developer = @application.developer
  end

  def application_is_posted?(match)
    Application.where(match: match).any?
  end

  def set_match
    if current_developer.all_matched_jobs.include? @job
      @match = Match.where(developer: current_developer, job: @job)
                    .first_or_create
    else
      redirect_to dashboard_developers_path, notice: "Sorry you can't apply to this job!"
    end
  end

  def set_opened(application)
    if application.pending?
      application.opened!
    end
  end

  def application_params
    params.require(:application).permit(:message, :last_mail_sent)
  end

  def developer_params
    params.require(:application).permit(developer: [resumes: []])[:developer]
  end
end
