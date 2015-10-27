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

  def show
    @pull_request = PullRequest.find(params[:id])
    user_name, repo_name, pr_number = fetch_pr_details(@pull_request)
    github = Github.new
    github_prs = github.pulls.list user: "CodeAstra", repo: "WereWolf"
    @pr_object = github_prs.select{|pr| pr.number == pr_number.to_i}.first
  end

private
  def pull_request_params
    params.require(:pull_request).permit(:link)
  end

  def fetch_pr_details(pull_request)
    details = pull_request.link.split("github.com")[1].split("/")
    return [details[1], details[2], details[4]]
  end
end
