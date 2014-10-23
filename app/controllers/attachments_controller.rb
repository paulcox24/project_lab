class AttachmentsController < ApplicationController
  def index
    set_project
    @attachments = @project.attachments.all
  end

  def new
    set_project
    @attachment = Attachment.new
  end

  def create
    set_project
    @attachment = @project.attachments.build(attachment_params)

    if @attachment.save
      redirect_to project_attachments_path(@project)
    else
      render :new
    end
  end

  def destroy
    set_project
    @attachment = @project.attachments.find_by(id: params[:id]) if @project 
    @attachment.destroy
    redirect_to project_attachments_path(@project)
  end

  private

  def attachment_params
    params.require(:attachment).permit(:project_id, :photo)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
