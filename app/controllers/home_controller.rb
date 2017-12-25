class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ]

  def index
  	if @tenant
      params[:tenant_id] = @tenant.id
  	end
  end
end
