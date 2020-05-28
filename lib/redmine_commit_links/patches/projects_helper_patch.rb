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

        def project_settings_tabs_with_redmine_commit_links
          tabs = project_settings_tabs_without_redmine_commit_links

          return tabs unless @project.module_enabled?('commit_links')
          return tabs unless User.current.allowed_to?(:edit_project, @project)

          tabs << {
              :name => 'commit_links_project_settings',
              :action => :commit_links_manage_project_settings,
              :partial => 'projects/commit_links_project_settings',
              :label => 'redmine_commit_links.settings.label_redmine_commit_links'
          }

          tabs
        end

      end

    end
  end
end
