class DevelopersController < ApplicationController
  before_action :authenticate_developer!, only: [:edit_profile, :add_skills, :update, :dashboard]


  def show
    @developer = Developer.find(params[:id])
  end

  def edit_profile
    @developer = current_developer
  end

  def add_skills
    @developer = current_developer
  end

  def update
    @developer = current_developer
    @developer.update(developer_params)
    @developer.set_url
    @developer.first_login = true
    if @developer.save
      redirect_to add_skills_developers_path
    else
      render action: 'edit_profile'
    end
  end


  def dashboard
    @developer = current_developer
    @jobs = @developer.matched_job
    @developer.check_for_first_matches
    @skills = @developer.skills
    @benefits = @jobs.distinct.pluck(:benefits).flatten.uniq
    @cultures = @jobs.distinct.pluck(:cultures).flatten.uniq
    @salaries = @jobs.distinct.pluck(:max_salary).flatten.uniq
    @cities = @jobs.distinct.pluck(:city).flatten.uniq
    @jobs = @jobs.filter_by_benefits(params[:benefits]) if params[:benefits].present?
    @jobs = @jobs.filter_by_cultures(params[:cultures]) if params[:cultures].present?
    @jobs = @jobs.where(city:  params[:cities]) if params[:cities].present?
    if params[:remote].present?
      case params[:remote].sort
      when ["Remote jobs"]
        @jobs = @jobs.where(remote: ["remote"])
      when ["Office jobs"]
        @jobs = @jobs.where(remote: ["office"])
      when ["Both office and remote jobs"]
        @jobs = @jobs.where(remote: ["remote", "office"])
      when ["Office jobs", "Remote jobs"]
        @jobs = @jobs.where(remote: ["remote"]).or(@jobs.where(remote: ["office"]))
      when ["Both office and remote jobs", "Office jobs"]
        @jobs = @jobs.where(remote: ["remote", "office"]).or(@jobs.where(remote: ["office"]))
      when ["Both office and remote jobs", "Remote jobs"]
        @jobs = @jobs.where(remote: ["remote", "office"]).or(@jobs.where(remote: ["remote"]))
      else
          @jobs 
      end
    end
    @jobs = @jobs.filter_by_user_salary(params[:salaries]) if params[:salaries].present?
  end

  private

  def developer_params
    params.require(:developer).permit(:email, :password, :password_confirmation, :first_name, :last_name, :avatar, :min_salary, :need_us_permit, :city, :zip_code, :mobility, :state, :country, :linkedin_url, :github_url, :full_mobility, remote:[], resumes: [])
  end

end
