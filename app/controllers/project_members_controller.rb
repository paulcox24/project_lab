class ProjectMembersController < ApplicationController
  before_action :set_project

  def new
    @project_member = ProjectMember.new
  end

  def create
    @project_member = @project.project_members.build(project_member_params)

    if current_user == @project.creator
      if @project_member.save
        redirect_to project_path(@project)
      else
        render :new
      end
    else
      redirect_to @project, alert: "Only project creator can add members"   
    end  
  end

  def destroy
    @project_member = ProjectMember.find(params[:id])
    if current_user == @project.creator
      @project_member.destroy
      redirect_to project_path(@project), notice: 'Member was successfully deleted.'
    else
      redirect_to @project, alert: "Only project creator can delete members"   
    end  
  end

  private
  def project_member_params
    params.require(:project_member).permit(:project_id, :user_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
