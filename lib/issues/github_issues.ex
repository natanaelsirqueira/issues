defmodule Issues.GithubIssues do
  @user_agent  [ {"User-agent", "Elixir dave@pragprog.com"} ]

  def fetch(user, project) do
    issues_url(user, project)
    |> Tesla.get(headers: @user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response(%{status: 200, body: body}) do
    { :ok,    body }
  end

  def handle_response(%{status: _,   body: body}) do
    { :error, body }
  end
end
