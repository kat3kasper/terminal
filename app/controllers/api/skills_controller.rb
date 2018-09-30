class Api::SkillsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @skills = Competence.all
  end

  def create
    get_entity

    if @developer
      @competence = Competence.find(skill_params[:competence_id])
      skill = { name: skill_params[:name], level: skill_params[:level] }
      @developer.skills.new(skill).save
      @implications = @competence.transitive_implications
      @implications.each do |i|
        skill = {name: i.value, level: skill_params[:level]}
        @developer.skills.new(skill).save
      end
      @suggestions = @competence.transitive_suggestions
      skills = { skills: @developer.skills,
                 implications: @implications,
                 suggestions: @suggestions }
      render json: skills, status: :created
    else
      @job.skills.new(skill_params).save
      render json: @job.skills, status: :created
    end
  end

  def destroy
    get_entity
    if @developer
      @developer.skills.find_by_name(params[:name]).destroy
      render json: @developer.skills, status: :created
    else
      @job.skills.find_by_name(params[:name]).destroy
      render json: @job.skills, status: :created
    end
  end

  private

  def get_entity
    @developer = Developer.find(params[:developer_id]) if params[:developer_id]
    @job = Job.find(params[:job_id]) if params[:job_id]
  end

  def skill_params
    params.require(:skill).permit(:name, :level, :competence_id)
  end
end
