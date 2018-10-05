class JobsController < ApplicationController
  before_action :authenticate_recruiter!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :skills, :benefits]
  before_action :authorize_action, only: [:edit, :update, :destroy, :skills, :benefits]

  def new
    redirect_to new_subscriber_path unless current_recruiter.company.can_add_job?
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.active = false unless current_recruiter.company.can_add_job?
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
    if job_params[:active]
      if activating_job and not current_recruiter.company.can_add_job?
        return redirect_to new_subscriber_path
      end

      @job.update(job_params)
      return redirect_to dashboard_companies_path
    end

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

  def destroy
    if @job.destroy
      redirect_to recruiter_root_path, notice: 'Your job was successfully deleted.'
    else
      redirect_to recruiter_root_path, notice: 'There was an error deleting your job.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def authorize_action
    if !current_recruiter.company.jobs.include?(@job)
      redirect_to dashboard_companies_path, notice: 'Not authorized.'
    end
  end

  def job_params
    params.require(:job).permit(
      :title,
      :description,
      :city,
      :zip_code,
      :state,
      :country,
      :max_salary,
      :employment_type,
      :can_sponsor,
      :active,
      remote: [],
      benefit_ids: [],
      culture_ids: []
    )
  end

  def activating_job
    job_params[:active] and not @job.active
  end
end
