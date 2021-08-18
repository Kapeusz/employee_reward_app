defmodule EmployeeRewardApp.Repo.Migrations.RemovePoolIdFromUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :pool_id
    end
  end
end
