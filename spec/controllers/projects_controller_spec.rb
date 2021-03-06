require 'spec_helper'

describe ProjectsController do
 
  before :each do
    login_user
  end

  def valid_attributes
    {:title => "New project", :description => "This is a new project"}
  end

  describe "GET index" do
    it "assigns all projects as @projects" do
      project = @user.projects.create! valid_attributes
      get :index
      assigns(:projects).should eq([project])
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      project = @user.projects.create! valid_attributes
      get :show, :id => project.id
      assigns(:project).should eq(project)
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      project = @user.projects.create! valid_attributes
      get :edit, :id => project.id
      assigns(:project).should eq(project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
      end

      it "assigns a newly created project as @project" do
        Project.any_instance.stub(:limit_not_exceeded).and_return(true)
        post :create, :project => valid_attributes
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it "redirects to the created project" do
        Project.any_instance.stub(:limit_not_exceeded).and_return(true)
        post :create, :project => valid_attributes
        response.should redirect_to assigns(:project)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        @user.projects.any_instance.stub(:save).and_return(false)
        post :create, :project => {}
        assigns(:project).should be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        @user.projects.any_instance.stub(:save).and_return(false)
        post :create, :project => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        project = @user.projects.create! valid_attributes
        @user.projects.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => project.id, :project => {'these' => 'params'}
      end

      it "assigns the requested project as @project" do
        Project.any_instance.stub(:limit_not_exceeded).and_return(true)
        project = @user.projects.create! valid_attributes
        put :update, :id => project.id, :project => valid_attributes
        assigns(:project).should eq(project)
      end

      it "redirects to the project" do
        Project.any_instance.stub(:limit_not_exceeded).and_return(true)
        project = @user.projects.create! valid_attributes
        put :update, :id => project.id, :project => valid_attributes
        response.should redirect_to(project)
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        project = @user.projects.create! valid_attributes
        @user.projects.any_instance.stub(:save).and_return(false)
        put :update, :id => project.id, :project => {}
        assigns(:project).should eq(project)
      end

      it "re-renders the 'edit' template" do
        project = @user.projects.create! valid_attributes
        @user.projects.any_instance.stub(:save).and_return(false)
        put :update, :id => project.id, :project => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project = @user.projects.create! valid_attributes
    end

    it "redirects to the projects list" do
      project = @user.projects.create! valid_attributes
      delete :destroy, :id => project.id
      response.should redirect_to(projects_url)
    end
  end
end
