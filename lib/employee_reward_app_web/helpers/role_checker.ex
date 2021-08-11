defmodule EmployeeRewardAppWeb.Helpers.RoleChecker do
  alias EmployeeRewardApp.Repo
  alias EmployeeRewardApp.Role

  def is_admin?(user) do
    (role = Repo.get(Role, user.role_id)) && role.admin
  end
end
