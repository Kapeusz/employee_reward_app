defmodule EmployeeRewardApp.Repo.Migrations.ModifyUserFieldInPools2 do
  use Ecto.Migration

  def change do
    alter table(:pools) do
      add :user_id, references(:users), on_delete: :delete_all
    end
    create index(:pools, [:user_id])
  end
end
