defmodule EmployeeRewardApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string
      add :email, :string
      add :password_digest, :string

      timestamps()
    end

  end
end
