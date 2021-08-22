defmodule EmployeeRewardApp.Repo.Migrations.RenameUserIdFieldInGivenPoints do
  use Ecto.Migration

  def change do
    alter table(:given_points) do
      remove :given_from_user_id
      add :user_id, references(:users), on_delete: :delete_all
    end
    create index(:given_points, [:user_id])
  end
end
