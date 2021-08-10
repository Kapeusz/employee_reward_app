defmodule EmployeeRewardAppWeb.SessionController do
  use EmployeeRewardAppWeb, :controller
  import Comeonin.Bcrypt

  alias EmployeeRewardApp.Accounts.User
  alias EmployeeRewardApp.Repo
  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.changeset(%User{}, _params))
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}})
  when not is_nil(email) and not is_nil(password) do
    user = Repo.get_by(User, email: email)
    sign_in(user, password, conn)
  end

  def create(conn, _) do
    failed_login(conn)
  end

  defp failed_login(conn) do
    Bcrypt.no_user_verify()
    conn
    |> put_session(:current_user, nil)
    |> put_flash(:error, "Invalid email/password combination!")
    |> redirect(to: Routes.page_path(conn, :index))
    |> halt()
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    failed_login(conn)
  end

  defp sign_in(user, password, conn) do
    if Bcrypt.verify_pass(password, user.password_digest) do
      conn
      |> put_session(:current_user, %{id: user.id, email: user.email})
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      failed_login(conn)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
