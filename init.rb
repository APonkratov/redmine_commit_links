require 'redmine'
require 'redmine_commit_links'

Redmine::Plugin.register :redmine_commit_links do
  name 'Redmine Commit Links'
  author 'Aleksandr Ponkratov'
  description 'Display links to Gitlab, Github, Gitea commits'
  version '0.0.2'
  url 'https://github.com/APonkratov/redmine_commit_links'
  author_url 'https://github.com/APonkratov'

  requires_redmine version_or_higher: '3.4'

  project_module :commit_links do
    permission :view_associated_commits, {}
  end
end

Rails.configuration.to_prepare do
  [
      [ProjectsController, RedmineCommitLinks::Patches::ProjectsControllerPatch],
      [ProjectsHelper, RedmineCommitLinks::Patches::ProjectsHelperPatch]
  ].each do |classname, modulename|
    unless classname.included_modules.include?(modulename)
      classname.send(:include, modulename)
    end
  end
end