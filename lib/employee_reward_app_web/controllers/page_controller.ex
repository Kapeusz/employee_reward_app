defmodule EmployeeRewardAppWeb.PageController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Accounts
  alias EmployeeRewardApp.Role
  alias EmployeeRewardApp.Repo
  alias EmployeeRewardApp.Points.Pool
  alias EmployeeRewardApp.Points.GivenPoint

  def index(conn, _params) do
    users = Accounts.list_users
    |> Repo.preload(:pool)
    single_user = get_session(conn, :current_user)
    if is_nil(single_user) do
      render(conn, "index.html", users: users)
    else
    user_id = single_user.id
    user = Accounts.get_user!(user_id)
    |> Repo.preload([:pool])

     render(conn, "index.html", users: users, user: user)
    end
end
end
