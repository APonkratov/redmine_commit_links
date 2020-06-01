class CommitsController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :check_if_login_required

  def index
    @commits = Commit.all
  end

  def event
    event_handler = find_event_handler
    return head :bad_request unless event_handler
    if event_handler.provider == 'gitea'
      return head :forbidden unless event_handler.verify(params[secret])
    else
      return head :forbidden unless event_handler.verify(request)
    end

    if params[:commits].present?
      branch = params[:ref].split("/").last
      repo_name = params[:repository][:name]
      repo_full_name = params[:repository][:full_name]
      repo_url = params[:repository][:html_url]

      params[:commits].each do |last_commit|
        commit_info = {}
        commit_info[:provider] = event_handler.provider
        commit_info[:title] = last_commit[:message]
        commit_info[:url] = last_commit[:url]
        commit_info[:repo_name] = repo_name
        commit_info[:repo_full_name] = repo_full_name
        commit_info[:repo_url] = repo_url
        commit_info[:branch] = branch
        commit_info[:display_id] = last_commit[:id]
        commit_info[:author_name] = last_commit[:author][:name]

        commit =
            Commit.find_or_initialize_by(url: commit_info[:url])
        commit.update!(commit_info)
      end
      head :ok
    end
  end

  private

  def find_event_handler
    RedmineCommitLinks.event_handlers.detect do |event_handler|
      event_handler.matches?(request)
    end
  end
end
