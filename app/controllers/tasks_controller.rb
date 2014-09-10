class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Tasks.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def edit
  end

  def update
   if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to projects_url, notice: 'Task was successfully deleted.'
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :delivery_minutes, :is_completed)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
