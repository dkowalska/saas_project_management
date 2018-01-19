class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :new, :create]

  def new
    authorize Task, :can_create_tasks?
    @task = Task.new
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
