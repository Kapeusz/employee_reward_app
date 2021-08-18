defmodule EmployeeRewardApp.Repo.Migrations.AddUserIdToPoolsTable do
  use Ecto.Migration

  def change do
    alter table(:pools) do
      add :user_id, references(:users)
    end
    create index(:pools, [:user_id])
  end
end
