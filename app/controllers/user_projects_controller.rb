class UserProjectsController < ApplicationController
  before_action :set_user_project, only: [:destroy]

  # DELETE /user_projects/1
  # DELETE /user_projects/1.json
  def destroy
    @user_project.destroy
    redirect_to users_tenant_project_url(id: @user_project.project_id, tenant_id: @user_project.project.tenant_id), notice: 'User was successfully removed from project.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_project
      @user_project = UserProject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_project_params
      params.require(:user_project).permit(:project_id, :user_id)
    end
end
