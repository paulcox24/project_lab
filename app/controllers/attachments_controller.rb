class AttachmentsController < ApplicationController
  def new
    set_project
  end

  def create
    set_project
  end

  def destroy
    set_project
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end
end
