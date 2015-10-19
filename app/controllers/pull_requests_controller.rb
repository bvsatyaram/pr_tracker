class PullRequestsController < ApplicationController
  def new
    @pull_request = PullRequest.new
  end

  def create
    @pull_request = PullRequest.new(pull_request_params)
    @pull_request.save!
    redirect_to pull_requests_path
  end

  def index
    @pull_requests = PullRequest.all
  end

private
  def pull_request_params
    params.require(:pull_request).permit(:link)
  end
end
