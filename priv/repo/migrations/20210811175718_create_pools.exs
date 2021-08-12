defmodule EmployeeRewardApp.Repo.Migrations.CreatePools do
  use Ecto.Migration

  def change do
    create table(:pools) do
      add :starting_points, :integer
      add :used_points, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:pools, [:user_id])
  end
end
