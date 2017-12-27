class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ]

  def index
  	if @tenant
      @projects = Project.by_plan_and_tenant(@tenant.id)
      params[:tenant_id] = @tenant.id
  	end
  end
end
