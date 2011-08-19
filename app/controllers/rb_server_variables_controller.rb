class RbServerVariablesController < RbApplicationController
  unloadable

  def show
    @project = Project.find_by_id(params[:project_id])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def jquery
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
