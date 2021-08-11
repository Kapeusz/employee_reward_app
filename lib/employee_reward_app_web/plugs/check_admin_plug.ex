defmodule EmployeeRewardAppWeb.CheckAdminPlug do
  use EmployeeRewardAppWeb, :controller

  @behaviour Plug

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = get_session(conn, :current_user)
    if user && EmployeeRewardAppWeb.Helpers.RoleChecker.is_admin?(user) do
      conn
    else
      conn
      |> send_resp(:unauthorized, "You don't have permission to visit this page.")
      |> halt()
    end
    conn
  end
end
