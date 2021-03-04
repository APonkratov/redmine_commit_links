require 'redmine'
require 'redmine_commit_links'
require 'redmine_commit_links/patches/projects_controller_patch'
require 'redmine_commit_links/patches/projects_helper_patch'

Redmine::Plugin.register :redmine_commit_links do
  name 'Redmine Commit Links'
  author 'Aleksandr Ponkratov'
  description 'Display links to Gitlab, Github, Gitea commits'
  version '0.1.0'
  url 'https://github.com/APonkratov/redmine_commit_links'
  author_url 'https://github.com/APonkratov'

  requires_redmine version_or_higher: '3.4'

  project_module :commit_links do
    permission :view_associated_commits, {:projects => [:commit_links_settings]}, :require => :member
  end

  settings default: {
      commit_links_api_key: ''
  }, partial: 'settings/settings'
end

Rails.configuration.to_prepare do
  require_dependency 'projects_helper'
  require_dependency 'projects_controller'
  unless ProjectsHelper.included_modules.include?(RedmineCommitLinks::Patches::ProjectsHelperPatch)
    ProjectsHelper.send(:include, RedmineCommitLinks::Patches::ProjectsHelperPatch)
  end
  unless ProjectsController.included_modules.include?(RedmineCommitLinks::Patches::ProjectsControllerPatch)
    ProjectsController.send(:include, RedmineCommitLinks::Patches::ProjectsControllerPatch)
  end
end