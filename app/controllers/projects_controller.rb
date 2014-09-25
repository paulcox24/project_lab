class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :titleize_params, only: [:edit, :update]
  before_action :find_user

  def index
    @projects = Project.all.order(:due_date_at)
  end

  def show
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
    @project.creator = current_user
  end

  def create
    @project = Project.new(project_params)
    @project.creator = current_user
    titleize_params
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user == @project.creator
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit 
      end
    else
      redirect_to @project, alert: "Only #{@project.creator.name} can edit this project"
    end  
  end

  def destroy
    if @user == @project.creator
      @project.destroy
      redirect_to projects_path, notice: 'Project was successfully deleted.'
    else
      redirect_to @project, alert: "Only #{@project.creator.name} can delete this project"
    end  
  end

  private
  def project_params
    params.require(:project).permit(:name, :description, :due_date_at, :creator, tasks_attributes: [:id, :name, :description, :is_completed, :delivery_minutes, :project_id, :_destroy, :user_id, :creator], project_members_attributes:[:id, :user_id, :project_id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def titleize_params
    @project.name = @project.name.titleize
  end

  def find_user
    @user = current_user
    @users = User.all
  end
end
