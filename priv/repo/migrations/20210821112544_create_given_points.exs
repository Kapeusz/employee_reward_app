defmodule EmployeeRewardApp.Repo.Migrations.CreateGivenPoints do
  use Ecto.Migration

  def change do
    create table(:given_points) do
      add :given_from_user_id, references(:users), on_delete: :delete_all
      add :given_points, :integer
      add :given_to_user_id, :integer

      timestamps()
    end
    create index(:given_points, [:given_from_user_id])
  end
end
