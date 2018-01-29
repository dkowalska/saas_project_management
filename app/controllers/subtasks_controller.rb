class SubtasksController < ApplicationController

  def create
    @subtask = Subtask.new(subtask_params)

    if @subtask.save
      render :partial => "subtasks/subtask", :locals => { :subtask => @subtask }, :layout => false, :status => :created
    else
      render :js => "alert('error adding subtask');"
    end
  end

  def destroy
    @subtask = Subtask.find(params[:id])
    if @subtask.destroy
      render :json => @subtask, :status => :ok
    else
      render :js => "alert('error deleting subtask');"
    end
  end

  def update
    @subtask = Subtask.find(params[:id])

    respond_to do |format|
    if @subtask.update_attributes(subtask_params)
      format.json { respond_with_bip(@subtask) }
    else
      format.json { respond_with_bip(@subtask) }
    end
  end
  end

  def subtask_params
    params.require(:subtask).permit(:description, :task_id, :user_id, :status)
  end
end