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

  def dashboard
    @developer = current_developer
    @jobs = @developer.matched_job
    @developer.check_for_first_matches
    @skills = @developer.skills
    @benefits = @jobs.pluck(:benefits).flatten.uniq.compact
    @cultures = @jobs.pluck(:cultures).flatten.uniq.compact
    @salaries = @jobs.pluck(:max_salary).flatten.uniq.compact
    @cities = @jobs.pluck(:city).flatten.uniq.compact
    @jobs = @jobs.filter_by_benefits(params[:benefits]) if params[:benefits].present?
    @jobs = @jobs.filter_by_cultures(params[:cultures]) if params[:cultures].present?
    @jobs = @jobs.where(city: params[:cities]) if params[:cities].present?
    if params[:remote].present?
      params[:remote] = ["remote"] if params[:remote] == ["Remote"]
      params[:remote] = ["office"] if params[:remote] == ["Office"]
      params[:remote] = ["remote", "office"] if params[:remote] == ["Both"]
      @jobs = @jobs.where(remote: params[:remote])
    end
    @jobs = @jobs.filter_by_salary(params[:salaries]) if params[:salaries].present?
    @jobs = @jobs.sort_by { |j| j.vetted ? 0 : 1 }
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
    params.require(:developer).permit(:email, :password, :password_confirmation, :first_name, :last_name, :avatar, :min_salary, :need_us_permit, :city, :zip_code, :mobility, :state, :country, :linkedin_url, :github_url, :full_mobility, remote:[], resumes: [])
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
