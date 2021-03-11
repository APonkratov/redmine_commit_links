module RedmineCommitLinks
  module EventHandlers
    class Gitlab
      include GitBase

      def matches?(request)
        request.headers['X-Gitlab-Event'] == 'Push Hook' ||
          (request.headers['X-Gitlab-Event'] == 'System Hook' &&
           request.request_parameters['event_name'] == 'push')
      end

      def verify(request)
        request.headers['X-Gitlab-Token'] == get_api_key
      end

      def provider
        'gitlab'
      end

      def parse_params(params)
        if params[:commits].present?
          commits_list = []
          branch = params[:ref].split("/").last
          repo_name = params[:repository][:name]
          params[:commits].each do |last_commit|
            commit_info = {}
            commit_info[:provider] = 'gitlab'
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
