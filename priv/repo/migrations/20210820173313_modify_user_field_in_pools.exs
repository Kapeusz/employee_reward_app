defmodule EmployeeRewardApp.Repo.Migrations.ModifyUserFieldInPools do
  use Ecto.Migration

  def change do
    alter table(:pools) do
      remove :user_id, references(:users)
    end
  end
end
