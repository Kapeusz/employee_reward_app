defmodule EmployeeRewardAppWeb.UserController do
  use EmployeeRewardAppWeb, :controller

  alias EmployeeRewardApp.Accounts
  alias EmployeeRewardApp.Accounts.User
  alias EmployeeRewardApp.Role
  alias EmployeeRewardApp.Repo

  plug :authorize_admin when action in [:new, :create, :delete]
  plug :authorize_user when action in [:edit, :update]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    roles = Repo.all(Role)
    changeset = User.changeset(%User{}, _params)
    render(conn, "new.html", changeset: changeset, roles: roles)
  end

  def create(conn, %{"user" => user_params}) do
    roles = Repo.all(Role)
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, roles: roles)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    |> Repo.preload([:role])
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    roles = Repo.all(Role)
    user = Repo.get!(User, id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, roles: roles)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    roles = Repo.all(Role)
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset, roles: roles)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  defp authorize_user(conn, _) do
    user = get_session(conn, :current_user)
    if user && (Integer.to_string(user.id) == conn.params["id"] || EmployeeRewardAppWeb.Helpers.RoleChecker.is_admin?(user)) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to modify that user!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  defp authorize_admin(conn, _) do
    user = get_session(conn, :current_user)
    if user && EmployeeRewardAppWeb.Helpers.RoleChecker.is_admin?(user) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to modify users!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
