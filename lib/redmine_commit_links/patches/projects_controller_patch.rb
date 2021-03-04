require_dependency 'projects_controller'


module RedmineCommitLinks
  module Patches
    module ProjectsControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods

        def commit_links_settings
          @settings = params[:settings]

          RedmineCommitLinks.default_settings.each do |k, v|
            @settings[k] ||= v
          end

          project_setting = CommitLinksSettings.for_project(@project).first_or_initialize
          project_setting.repo_base_url = @settings[:repo_base_url]

          if project_setting.save!
            flash[:notice] = l(:notice_successful_update)
          else
            flash[:error] = l('settings.error_update_not_successful')
          end

          redirect_to settings_project_path(@project, :tab => 'commit_links_settings')
        end

      end
    end
  end
end
