class TenantsController < ApplicationController

  before_action :set_tenant

  def edit
  end

  def update
    if current_user.valid_password?(tenant_params[:current_password])
      if @tenant.update(plan: tenant_params[:plan])
        flash[:notice] = 'Plan was successfully changed.'
        redirect_to root_url
      else
        flash[:error] = "Error - plan cannot be changed"
        render :edit
      end
    else
      flash[:error] = "Plan cannot be changed - incorrect password"
      render :edit
    end
  end

  private

    def set_tenant
      @tenant = Tenant.find(Tenant.current_tenant_id)
    end

    def tenant_params
      params.require(:tenant).permit(:plan, :current_password)
    end
end