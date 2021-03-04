module RedmineCommitLinks
  module EventHandlers
    module GitBase
      def get_api_key
        Setting.plugin_redmine_commit_links[:commit_links_api_key]
      end
    end
  end
end




