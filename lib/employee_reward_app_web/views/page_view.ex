defmodule EmployeeRewardAppWeb.PageView do
  use EmployeeRewardAppWeb, :view

  alias EmployeeRewardApp.Accounts
  alias EmployeeRewardApp.Points

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

end
