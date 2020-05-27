require 'redmine_commit_links/hooks'

module RedmineCommitLinks

  github_token = ENV['REDMINE_COMMIT_LINKS_GITHUB_WEBHOOK_TOKEN']
  gitlab_token = ENV['REDMINE_COMMIT_LINKS_GITLAB_WEBHOOK_TOKEN']
  gitea_token  = ENV['REDMINE_COMMIT_LINKS_GITEA_WEBHOOK_TOKEN']

  mattr_accessor :event_handlers
  self.event_handlers = [
    RedmineCommitLinks::EventHandlers::Gitea.new(token: gitea_token),
    RedmineCommitLinks::EventHandlers::Github.new(token: github_token),
    RedmineCommitLinks::EventHandlers::Gitlab.new(token: gitlab_token)
  ]

  def self.default_settings
    {
        :repo_base_url => ""
    }
  end

end
