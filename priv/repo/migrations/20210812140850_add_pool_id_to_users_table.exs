defmodule EmployeeRewardApp.Repo.Migrations.AddPoolIdToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :pool_id, references(:pools)
    end
    create index(:users, [:pool_id])
  end
end
