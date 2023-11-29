
require_relative 'redmine_commit_links/hooks'

module RedmineCommitLinks

  mattr_accessor :event_handlers
  self.event_handlers = [
    RedmineCommitLinks::EventHandlers::Gitea.new,
    RedmineCommitLinks::EventHandlers::Github.new,
    RedmineCommitLinks::EventHandlers::Gitlab.new
  ]

  def self.default_settings
    {
        :repo_base_url => ""
    }
  end

end
