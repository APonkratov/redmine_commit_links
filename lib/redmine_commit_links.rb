require 'redmine_commit_links/hooks'

module RedmineCommitLinks

  server_token = ENV['REDMINE_COMMIT_LINKS_TOKEN']

  mattr_accessor :event_handlers
  self.event_handlers = [
    RedmineCommitLinks::EventHandlers::Gitea.new(token: server_token),
    RedmineCommitLinks::EventHandlers::Github.new(token: server_token),
    RedmineCommitLinks::EventHandlers::Gitlab.new(token: server_token)
  ]

  def self.default_settings
    {
        :repo_base_url => ""
    }
  end

end
