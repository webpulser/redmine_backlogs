include RbCommonHelper

class RbTaskboardsController < RbApplicationController
  unloadable
  
  def show
    @issue_statuses_categories = IssueStatusesCategory.all
    @statuses = Tracker.find_by_id(RbTask.tracker).issue_statuses
    if @project = Project.find_by_id(params[:project_id])
      @stories = RbStory.sprint_backlog_with_project(@sprint, @project)
    else
      @stories = @sprint.all_stories
    end

    if @stories.size == 0
      @last_updated = nil
    else
      @last_updated = RbTask.find(:first,
                        :conditions => ['tracker_id = ? and fixed_version_id = ?', RbTask.tracker, @sprint.all_stories[0].fixed_version_id],
                        :order      => "updated_on DESC")
    end

    respond_to do |format|
      format.html { render :layout => "rb" }
    end
  end
  
  def index
    @projects = Project.all(:conditions => { :status => 1, :is_public => 0 } )
    @statuses = Tracker.find_by_id(RbTask.tracker).issue_statuses
    @stories = @sprint.all_stories

    if @stories.size == 0
      @last_updated = nil
    else
      @last_updated = RbTask.find(:first,
                        :conditions => ['tracker_id = ? and fixed_version_id = ?', RbTask.tracker, @sprint.all_stories[0].fixed_version_id],
                        :order      => "updated_on DESC")
    end

    respond_to do |format|
      format.html { render :layout => "rb" }
    end
  end
  
end
