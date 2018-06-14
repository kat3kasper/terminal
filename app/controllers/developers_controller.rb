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
    @skills = @developer.skills
    @benefits = benefits_list(@jobs)
    @cultures = cultures_list(@jobs)
    @salaries = salary_list(@jobs)
    @cities = cities_list(@jobs)
    @jobs = @jobs.filter_by_benefits(params[:benefits]) if params[:benefits].present?
    @jobs = @jobs.filter_by_cultures(params[:cultures]) if params[:cultures].present?
    @jobs = @jobs.where(city:  params[:cities]) if params[:cities].present?
    if params[:remote].present?
       params[:remote] = ["remote", "office"] if params[:remote] == ["both"]
       @jobs = @jobs.where(remote: params[:remote])
    end
    @jobs = @jobs.filter_by_user_salary(params[:salaries]) if params[:salaries].present?
  end

  private

  def developer_params
    params.require(:developer).permit(:email, :password, :password_confirmation, :first_name, :last_name, :avatar, :min_salary, :need_us_permit, :city, :zip_code, :mobility, :state, :country, :linkedin_url, :github_url, :full_mobility, remote:[], resumes: [])
  end

  def benefits_list(jobs)
    list = []
    jobs.each do |job|
      job.benefits.each do |benefit|
        list.push(benefit)
      end
    end
    return list.uniq.sort
  end

  def cultures_list(jobs)
    list = []
    jobs.each do |job|
      job.cultures.each do |benefit|
        list << benefit
      end
    end
    list.uniq.sort
  end

  def salary_list(jobs)
    list = []
    jobs.each do |job|
        list << job.max_salary
      end
    list.uniq.sort
  end

  def cities_list(jobs)
    list = []
    jobs.each do |job|
        list << job.city
      end
    list.uniq.sort
  end



end
