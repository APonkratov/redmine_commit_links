module RedmineCommitLinks
  module EventHandlers
    class Gitlab
      def initialize(token:)
        @token = token
      end

      def matches?(request)
        request.headers['X-Gitlab-Event'] == 'push' ||
          (request.headers['X-Gitlab-Event'] == 'System Hook' &&
           request.request_parameters['event_type'] == 'push')
      end

      def verify(request)
        request.headers['X-Gitlab-Token'] == @token
      end

      def parse_params(params)
        if params[:commits].present?
          commits_list = []
          branch = params[:ref].split("/").last
          repo_name = params[:repository][:name]
          params[:commits].each do |last_commit|
            commit_info = {}
            commit_info[:provider] = 'gitea'
            commit_info[:title] = last_commit[:message]
            commit_info[:branch] = branch
            commit_info[:id] = last_commit[:id]
            commit_info[:author_name] = last_commit[:author][:name]
            commits_list << commit_info
          end
        end
      end
    end
  end
end
