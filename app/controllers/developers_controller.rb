class DevelopersController < ApplicationController
  before_action :authenticate_developer!, only: [:edit_profile, :add_skills, :update, :dashboard]
  before_action :is_profile_complete?, only: [:dashboard]

  def show
    @developer = Developer.find(params[:id])
  end

  def edit_profile
    @developer = current_developer
  end

  def add_skills
    @developer = current_developer
    @show_tips = !ignored_countries.include?(lookup_country)
  end

  def update
    @developer = current_developer
    if developer_params[:resumes].present?
      @developer.resumes.destroy_all
    end
    @developer.update(developer_params)
    @developer.set_url
    @developer.first_login = true
    if @developer.save
      redirect_to add_skills_developers_path
    else
      render action: 'edit_profile'
    end
  end

  def update_matches_notifications
    @developer = current_developer
    @developer.update_attribute(:receives_matches_notifications, developer_params[:receives_matches_notifications])
    redirect_to dashboard_developers_path
  end

  def destroy
    @developer = current_developer
    developer_id = current_developer.id
    @applications = Developer.find(developer_id).applications
    @applications.where(status: ["opened", "contacted"]).find_each do |app|
      application_id = app.id
      job_id = app.job.id
      CompanyMailer.cancelled_application_advise(application_id, developer_id, job_id).deliver
    end
    @developer.destroy
    redirect_to root_path
  end

  def dashboard
    @developer = current_developer
    @jobs = @developer.active_matched_jobs
    @developer.check_for_first_matches
    @skills = @developer.skills
    @benefits = Benefit.where(id: @jobs.map(&:benefit_ids).flatten.uniq.compact)
    @cultures = Culture.where(id: @jobs.map(&:culture_ids).flatten.uniq.compact)
    @salaries = @jobs.pluck(:max_salary).flatten.uniq.compact
    @cities = @jobs.pluck(:city).flatten.uniq.compact
    if params[:culture_ids].present? || params[:benefit_ids].present?
      @culture_company_ids = Company.all.pluck(:id)
      @benefit_company_ids = @culture_company_ids
      @culture_company_ids = Company.company_ids_by_class(params[:culture_ids], Culture) if params[:culture_ids].present?
      @benefit_company_ids = Company.company_ids_by_class(params[:benefit_ids], Benefit) if params[:benefit_ids].present?
      @jobs = @jobs.filter_by_companies(@culture_company_ids & @benefit_company_ids)
    end
    @jobs = @jobs.where(city: params[:cities]) if params[:cities].present?
    if params[:remote].present?
      params[:remote] = ["remote"] if params[:remote] == ["Remote"]
      params[:remote] = ["office"] if params[:remote] == ["Office"]
      params[:remote] = ["remote", "office"] if params[:remote] == ["Both"]
      @jobs = @jobs.where(remote: params[:remote])
    end
    @jobs = @jobs.filter_by_salary(params[:salaries]) if params[:salaries].present?
    @jobs = @jobs.sort_by { |j| j.vetted ? 0 : 1 }
    @jobs = @jobs.reject { |j| j.has_applicant? @developer }
  end

  def is_profile_complete?
    if current_developer.first_name.nil? || current_developer.last_name.nil?
      redirect_to edit_profile_developers_path, alert: "Please complete your profile!"
    elsif current_developer.skills_array.empty?
      redirect_to add_skills_developers_path, alert: "Please complete your profile! Make sure to add some skills because the jobs we show you are based off of what skills you mention. We suggest adding as many as you can think of!"
    end
  end

  private

  def developer_params
    params.require(:developer).permit(
      :email,
      :password,
      :password_confirmation,
      :receives_matches_notifications,
      :subscribed_to_newsletter,
      :first_name,
      :last_name,
      :avatar,
      :min_salary,
      :need_us_permit,
      :city,
      :zip_code,
      :mobility,
      :state,
      :country,
      :linkedin_url,
      :github_url,
      :full_mobility,
      remote:[],
      resumes: []
    )
  end

  def lookup_country
    return 'US' if Rails.env.development?
    ip = request.remote_ip
    response = Net::HTTP.get_response URI.parse "http://ipinfo.io/#{ip}/country"
    if response.code == '200'
      response.body.strip rescue ''
    end
  end

  def ignored_countries
    ENV['ALLOWED_COUNTRIES'].split(',') rescue ['US']
  end
end
