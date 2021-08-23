defmodule EmployeeRewardAppWeb.PointsController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Role
  alias EmployeeRewardApp.Repo

  def add(conn, %{"given_points" => points_params}) do
    roles = Repo.all(Role)
    current_user = get_session(conn, :current_user)
    point = Ecto.build_assoc(current_user, :given_points)
    case EmployeeRewardApp.Points.insert_points(point, points_params) do
      {:ok, _points} ->
        conn
        |> put_flash(:info, "Points added successfully.")
        |> redirect(to: Routes.page_path(conn, :index))
        # EmployeeRewardAppWeb.PointsController.send_user_email(points_params)
        # EmployeeRewardAppWeb.PointsController.update_user_pool(points_params)
      {:error, changeset} ->
        render(conn, "error.html", changeset: changeset, roles: roles)
    end
  end

  # def send_user_email(%{"given_to_user_id" => id}) do
  #   EmployeeRewardApp.Accounts.User.given_to_user_email(id)
  #   |> EmployeeRewardApp.Emails.notification_email()
  #   |> EmployeeRewardApp.Mailer.deliver_now
  # end

  # def update_user_pool(%{"given_to_user_id" => id, "given_points" => points}) do
  #   EmployeeRewardApp.Repo.get_by(EmployeeRewardApp.Points.Pool, user_id: id)
  #   |> Ecto.Changeset.change(%{used_points: points})
  #   |> EmployeeRewardApp.Repo.update()
  # end
end
