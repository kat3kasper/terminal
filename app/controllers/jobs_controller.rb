class JobsController < ApplicationController
  before_action :authenticate_recruiter!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :skills]
  before_action :authorize_action, only: [:edit, :update, :destroy, :skills]

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
        format.html { redirect_to skills_job_path(@job) } if step == 'skills'
      else
        format.html { render :new }
      end
    end
  end

  def update
    if job_params[:active]
      if activating_job && !current_recruiter.company.can_add_job?
        return redirect_to new_subscriber_path
      end

      @job.update(job_params)
      return redirect_to dashboard_companies_path
    end

    step = params[:job][:navigate_to]

    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to skills_job_path(@job) } if step == 'skills'
      else
        format.html { render :edit, notice: "Please select at least one value." } if step == 'skills'
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
      remote: []
    )
  end

  def activating_job
    job_params[:active] and not @job.active
  end
end
