require 'rails_helper'

RSpec.describe ProjectMembersController, :type => :controller do

  before { single_login_user(create(:login_user)) }
  let!(:project) { create(:second_project, creator: @user) }

  describe 'GET new' do
    it 'returns http success' do
      get :new, project_id: project.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    context 'with valid info' do
      it 'should create a new project member' do
        expect{
          post :create, project_id: project.id,
                        project_member: {user_id: 1}
        }.to change(ProjectMember,:count).by(1)
      end
    end

    context 'user is not creator' do
      it 'should redirect to the project page' do
        user = FactoryGirl.create(:login_user)
        project = FactoryGirl.create(:random_project, creator: user)
        expect{
          post :create, project_id: project.id,
                        project_member: {user_id: 1}
        }.to change(ProjectMember,:count).by(0)
        expect(response).to redirect_to project
      end
    end

    context 'with invalid data' do
      it 'does not save the new project member' do
        expect{
          post :create, project_id: project.id, project_member: {user_id: 'a'}
        }.to_not change(ProjectMember,:count)
      end
      
      it 're-renders the new method' do
        post :create, project_id: project.id, project_member: {user_id: 'a'}
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
    it "should redirect to the project's page" do
      delete :destroy, project_id: project.id, id: FactoryGirl.create(:project_member)
      expect(response).to redirect_to project
    end
  end

end
