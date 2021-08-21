defmodule EmployeeRewardAppWeb.UserPointsView do
  use EmployeeRewardAppWeb, :view
  alias EmployeeRewardApp.Accounts.User
  alias EmployeeRewardApp.Points.Pool

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end


end
