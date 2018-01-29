class ArtifactsController < ApplicationController
  before_action :set_artifact, only: [:show, :edit, :update, :destroy, :download]

  # GET /artifacts
  # GET /artifacts.json
  def index
    @artifacts = Artifact.all
  end

  # GET /artifacts/1
  # GET /artifacts/1.json
  def show
  end

  # GET /artifacts/new
  def new
    @project = Project.find(params[:project_id])
    authorize @project, :can_manage_artifacts?
    @artifact = Artifact.new
    @artifact.project_id = params[:project_id]
    @artifact.task_id = params[:task_id]
  end

  # GET /artifacts/1/edit
  def edit
  end

  # POST /artifacts
  # POST /artifacts.json
  def create
    @artifact = Artifact.new(artifact_params)
    create_result = @artifact.save

    if create_result 
      if artifact_params[:task_id].empty?
        redirect_to tenant_project_url(tenant_id: Tenant.current_tenant_id, id: @artifact.project_id), notice: 'Attachment was successfully uploaded.'
      else
        redirect_to tenant_project_task_url(tenant_id: Tenant.current_tenant_id, project_id: @artifact.project_id, id: @artifact.task_id), notice: 'Attachment was successfully uploaded.'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /artifacts/1
  # PATCH/PUT /artifacts/1.json
  def update
    if @artifact.update(artifact_params)
      redirect_to @artifact, notice: 'Attachment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /artifacts/1
  # DELETE /artifacts/1.json
  def destroy
    authorize @artifact, :can_manage_artifacts?
    if @artifact.destroy
      render :json => @artifact, :status => :ok
    else
      render :js => "alert('error deleting attachment');"
    end
    #redirect_to tenant_project_url(tenant_id: Tenant.current_tenant_id, id: @artifact.project_id), notice: 'Artifact was successfully destroyed.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artifact
      @artifact = Artifact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artifact_params
      params.require(:artifact).permit(:name, :project_id, :upload, :task_id)
    end
end
