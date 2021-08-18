defmodule EmployeeRewardApp.Repo.Migrations.RemoveUserIdFromPools do
  use Ecto.Migration

  def change do
    alter table(:pools) do
      remove :user_id
    end
  end
end
