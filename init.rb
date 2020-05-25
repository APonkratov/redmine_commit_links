Redmine::Plugin.register :redmine_commit_links do
  name 'Redmine Commit Links'
  author 'Aleksandr Ponkratov'
  description 'Display links to Gitlab, Github, Gitea commits'
  version '0.0.1'
  url 'https://github.com/APonkratov/redmine_commit_links'
  author_url 'https://github.com/APonkratov'

  requires_redmine version_or_higher: '3.0'

  project_module :commit_links do
    permission :view_associated_commits, {}
  end
end

require 'redmine_commit_links'
