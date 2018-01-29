class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy_from_list, :destroy_from_show]
  before_action :set_project, only: [:show, :edit, :update, :destroy_from_list, :destroy_from_show, :new, :create]
  before_action :set_tenant, only: [:show, :edit, :update, :destroy_from_list, :destroy_from_show, :new, :create]

  def new
    authorize Task, :can_create_tasks?
    @task = Task.new
  end

  def create
    authorize Task, :can_create_tasks?
    @task = Task.new(task_params)
    if @task.save
      redirect_to tenant_project_path(id: @project.id, tenant_id: @tenant.id), notice: 'Task was successfully created.' 
    else
      render :new
    end
  end

  def destroy_from_list
    if @task.destroy
      render :json => @task, :status => :ok 
    else
      render :js => "alert('error deleting task');" 
    end
  end

  def destroy_from_show
    if @task.destroy
      redirect_to tenant_project_path(id: @project.id, tenant_id: @tenant.id), notice: 'Task was successfully deleted.'
    else
      redirect_to tenant_project_path(id: @project.id, tenant_id: @tenant.id), error: 'Task could not be deleted.'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tenant_project_task_path(id: @task.id, project_id: @project.id, tenant_id: @tenant.id), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def show
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :start_date, :end_date, :status, :priority, :tenant_id, :project_id)
    end

    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
    end

end
