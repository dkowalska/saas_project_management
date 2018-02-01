class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ]

  def index

    if current_user
      if session[:tenant_id]
        Tenant.set_current_tenant session[:tenant_id]
      else
        Tenant.set_current_tenant current_user.tenants.first
      end
      @tenant = Tenant.current_tenant
      @all_projects = Project.by_user_plan_and_tenant(@tenant.id, current_user).order('title ASC')
      @current_projects = @all_projects.where("expected_start_date <= ? AND expected_completion_date >= ?", Date.today, Date.today)
      @past_projects = @all_projects.where("expected_completion_date < ?", Date.today)
      @future_projects = @all_projects.where("expected_start_date > ?", Date.today)
      params[:tenant_id] = @tenant.id
    end
  end
end
