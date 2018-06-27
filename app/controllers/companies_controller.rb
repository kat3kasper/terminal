class CompaniesController < ApplicationController
  before_action :authenticate_recruiter!, only: [:new, :create, :dashboard, :edit]
  before_action :set_company, only: [:dashboard, :edit, :update]

  def new
    is_recruiter_in_company?
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    #Set company to recruiter after creation
    set_company_to_main_recruiter

    respond_to do |format|
      if @company.save
        CompanyMailer.welcome_company(@company).deliver
        format.html { redirect_to dashboard_companies_path, notice: 'Welcome on board, add your first job!' }
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
    @jobs = @company.jobs
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

  def is_recruiter_in_company?
    if !current_recruiter.company.nil?
      redirect_to dashboard_companies_path, notice: 'Already part of a company!'
    end
  end

  def company_params
    params.require(:company).permit(:name, :url, :industry, images: [])
  end

end
