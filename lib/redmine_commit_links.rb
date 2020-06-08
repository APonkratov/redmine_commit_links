require 'redmine_commit_links/hooks'

module RedmineCommitLinks

  server_token = ""
  # server_token = Setting["plugin_redmine_commit_links"]["token"]
  server_token = Setting.plugin_redmine_commit_links["token"]
  # server_token = '#{Setting.plugin_redmine_commit_links["token"]}'
  Rails.logger.info "Token " + server_token

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
