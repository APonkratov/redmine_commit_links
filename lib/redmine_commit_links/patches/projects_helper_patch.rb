require_dependency 'projects_helper'


module RedmineCommitLinks
  module Patches
    module ProjectsHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :project_settings_tabs, :redmine_commit_links
        end
      end

      module InstanceMethods

        def project_settings_tabs
          tabs = project_settings_tabs_without_commit_links_settings

          return tabs unless @project.module_enabled?('commit_links')
          return tabs unless User.current.allowed_to?(:edit_project, @project)

          tabs << {
              :name => 'commit_links_settings',
              :action => :commit_links_manage_settings,
              :partial => 'projects/commit_links_settings',
              :label => 'settings.label_redmine_commit_links'
          }

          tabs
        end
      end
    end
  end
end
