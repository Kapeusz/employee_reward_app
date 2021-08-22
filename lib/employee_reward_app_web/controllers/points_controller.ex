defmodule EmployeeRewardAppWeb.PointsController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Role
  alias EmployeeRewardApp.Repo
  alias EmployeeRewardApp.Points

  def add(conn, %{"given_points" => points_params}) do
    roles = Repo.all(Role)
    current_user = get_session(conn, :current_user)
    point = Ecto.build_assoc(current_user, :given_points)
    case EmployeeRewardApp.Points.insert_points(point, points_params) do
      {:ok, _points} ->
        conn
        |> put_flash(:info, "Points added successfully.")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset, roles: roles)
    end
  end

end
