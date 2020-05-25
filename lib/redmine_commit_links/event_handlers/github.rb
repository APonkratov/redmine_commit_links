module RedmineCommitLinks
  module EventHandlers
    class Github
      def initialize(token:)
        @token = token
      end

      def matches?(request)
        request.headers['X-GitHub-Event'] == 'push'
      end

      def verify(request)
        request.body.rewind
        payload = request.body.read

        signature =
          'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                                            @token,
                                            payload)

        Rack::Utils.secure_compare(signature,
                                   request.headers['X-Hub-Signature'])
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
