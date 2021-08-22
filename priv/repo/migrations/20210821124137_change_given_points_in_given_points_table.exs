defmodule EmployeeRewardApp.Repo.Migrations.ChangeGivenPointsInGivenPointsTable do
  use Ecto.Migration

  def change do
    alter table(:given_points) do
      remove :given_points
      add :points_given, :integer
    end
  end
end
