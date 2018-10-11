class CompaniesController < ApplicationController
  before_action :authenticate_recruiter!, only: [:new, :create, :dashboard, :edit]
  before_action :set_company, only: [:dashboard, :edit, :update]

  def index
    @companies = Company.active.includes(:benefits, :cultures)
    # binding.pry
    @companies = @companies.map{ |c| c if c.active_jobs.present? }.compact
    # @companies = @companies.left_outer_joins(:jobs).merge(Job.active).group_by(:company)
  end

  def new
    recruiter_in_company?
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        set_company_to_main_recruiter
        company_id = @company.id
        CompanyMailer.welcome_company(company_id).deliver
        if @company.is_member?
          format.html { redirect_to dashboard_companies_path, notice: 'Welcome on board, add your first job!' }
        else
          format.html { redirect_to new_subscriber_path }
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to dashboard_companies_path, notice: 'Your company was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def dashboard
    @company = current_recruiter.company
    if @company.nil?
      return redirect_to new_company_path, alert: 'Please create your company'
    end
    @jobs = @company.active_jobs.includes(:skills)
    @inactive_jobs = @company.inactive_jobs.includes(:skills)
  end

  private

  def set_company
    @company = current_recruiter.company
  end

  def set_company_to_main_recruiter
    current_recruiter.company = @company
    current_recruiter.main_recruiter = true
    current_recruiter.save
  end

  def recruiter_in_company?
    if current_recruiter.company.present?
      redirect_to dashboard_companies_path, notice: 'Already part of a company!'
    end
  end

  def company_params
    params.require(:company).permit(
      :name, :url, :industry, images: [], culture_ids: [], benefit_ids: []
    )
  end
end
