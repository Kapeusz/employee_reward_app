# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EmployeeRewardApp.Repo.insert!(%EmployeeRewardApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias EmployeeRewardApp.Repo
alias EmployeeRewardApp.Role
alias EmployeeRewardApp.Accounts.User

role = %Role{}
  |> Role.changeset(%{name: "Admin", admin: true})
  |> Repo.insert!

admin = %User{}
  |> User.changeset(%{full_name: "Kacper Muryn", email: "admin@admin.com", password: "admin", password_confirmation: "admin", role_id: role.id})
  |> Repo.insert!
