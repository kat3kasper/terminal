class JobsController < ApplicationController
  before_action :authenticate_recruiter!, only: [:new, :edit, :create, :update]
  before_action :set_job, only: [:show, :edit, :update, :skills, :benefits]
  before_action :authorize_action, only: [:edit, :update, :skills, :benefits]

  def new
    redirect_to new_subscriber_path if !current_recruiter.company.is_allowed_member
    @job = Job.new
  end

  def edit
  end

  def show
  end

  def create
    @job = Job.new(job_params)
    @job.company = current_recruiter.company
    @job.toggle_to_vetted
    step = params[:job][:navigate_to]
    respond_to do |format|
      if @job.save
        if step == "benefits"
          format.html { redirect_to benefits_job_path(@job) }
        elsif step == "skills"
          format.html { redirect_to skills_job_path(@job) }
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    step = params[:job][:navigate_to]

    respond_to do |format|
      if @job.update(job_params)
        if step == "benefits"
          format.html { redirect_to benefits_job_path(@job) }
        elsif step == "skills"
          format.html { redirect_to skills_job_path(@job) }
        end
      else
        if step == "benefits"
          format.html { render :edit }
        elsif step == "skills"
          format.html { render :benefits, notice: "Please select at least one value." }
        end
      end
    end

  end

  def skills
  end

  def benefits
  end

  private

  def set_job
    @job = Job.all.find(params[:id])
  end

  def authorize_action
    if !current_recruiter.company.jobs.include?(@job)
      redirect_to dashboard_companies_path, notice: 'Not authorized.'
    end
  end

  def job_params
    params.require(:job).permit(:title, :description, :city, :zip_code, :state, :country, :max_salary, :employment_type, :can_sponsor, :active, remote:[], benefits:[], cultures:[])
  end
end
