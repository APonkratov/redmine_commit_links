require_dependency 'projects_controller'

module RedmineCommitLinks
  module Patches
    module ProjectsControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods

        def commit_links_project_settings
          @settings = params[:settings][:commit_links]

          RedmineCommitLinks.default_settings.each do |k, v|
            @settings[k] ||= v
          end

          project_setting = CommitLinksSetting.for_project(@project).first_or_initialize
          project_setting.assign_attributes(@settings)

          if project_setting.save!
            flash[:notice] = l(:notice_successful_update)
          else
            flash[:error] = l('redmine_commit_links.settings.error_update_not_successful')
          end

          redirect_to settings_project_path(@project, :tab => 'commit_links_project_settings')
        end

      end
    end
  end
end
