class ProjectsController < ApplicationController
  before_action :verify_tenant
  before_action :set_project, only: [:show, :edit, :update, :destroy, :users, :add_user]
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :new, :create, :users, :add_user]

  # GET /projects
  # GET /projects.json
  def index
    @all_projects = Project.by_user_plan_and_tenant(params[:tenant_id], current_user)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    comments = @project.comments.where.not(id: nil).where(task_id: nil)
    @client_comm = comments.where(client_comm: true).order(id: :desc)
    @project_comm = comments.where(client_comm: false).order(id: :desc)
    @artifacts = @project.artifacts.where(task_id: nil)
  end

  # GET /projects/new
  def new
    authorize Project, :can_create_projects?
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    authorize @project, :can_manage_projects?
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.users << current_user
    if @project.save
      redirect_to root_url, notice: 'Project was successfully created.' 
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to root_url, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    authorize @project, :can_manage_projects?
    @project.destroy
    redirect_to root_url, notice: 'Project was successfully destroyed.'
  end

  def  users
    authorize @project, :can_manage_projects?
    @project_users = ((@project.users.where.not(role: "admin") + @tenant.users.where(role: "admin")) - [current_user]).sort_by &:email
    @other_users = (@tenant.users - (@project_users + [current_user])).sort_by &:email
  end

  def add_user
    @project_user = UserProject.new(user_id: params[:user_id], project_id: @project.id)

    if @project_user.save
      redirect_to users_tenant_project_url(id: @project.id, tenant_id: @project.tenant_id), notice: "User was succesfullty added to project"
    else
      redirect_to users_tenant_project_url(id: @project.id, tenant_id: @project.tenant_id), error: "User was not added to project"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :details, :expected_start_date, :expected_completion_date, :tenant_id)
    end

    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
    end

    def verify_tenant
      unless params[:tenant_id] == Tenant.current_tenant_id.to_s
        redirect_to :root, flash: { error: 'You are not authorized to access this page'}
      end
    end

end
