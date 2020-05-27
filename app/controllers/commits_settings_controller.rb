class CommitsSettingsController < ApplicationController

  unloadable

  before_action :find_project, :find_user
  before_action :authorize

  def update

    begin
      @project.update_attribute(:repo_base_url, params.str(:project, :repo_base_url))
      flash[:notice]= l(:label_project_repo_base_url_sucessfully_updated, :project => @project.name)

    rescue Exception => e
      flash[:error]= e.message
    end

    redirect_to :back

  end #def

end #class
