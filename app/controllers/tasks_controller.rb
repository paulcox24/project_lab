class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :find_user


  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
    @task.creator_id = current_user.id
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    @task.creator_id = current_user.id

    if @project.members.include? @user
      if @task.save
        redirect_to project_path(@project)
      else
        render :new
      end
    else
      redirect_to @project, alert: "Tasks can only be created by project members"
    end  
  end

  def edit
  end

  def update
    if @user == @task.user || @user.id == @task.creator_id
      @project = Project.find(params[:project_id])
      if @task.update(task_params)
        redirect_to @project, notice: 'Task was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to @task.project, alert: "Tasks can only be edited by assigned member"
    end    
  end

  def destroy
    if @user.id == @task.creator_id
      @task.destroy
      redirect_to @task.project, notice: 'Task was successfully deleted.'
    else
      redirect_to @task.project, alert: "Tasks can only be deleted by their creator"
    end   
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :delivery_minutes, :is_completed, :project_id, :user_id, :creator_id)
  end

  def set_task
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def find_user
    @user = current_user
    @users = User.all
  end

end
