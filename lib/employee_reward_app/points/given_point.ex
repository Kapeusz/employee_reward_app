defmodule EmployeeRewardApp.Points.GivenPoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "given_points" do
    field :given_points, :integer
    field :given_to_user_id, :integer
    belongs_to :user, EmployeeRewardApp.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(given_point, attrs) do
    given_point
    |> cast(attrs, [:user_id, :given_points, :given_to_user_id])
    |> validate_required([:user_id, :given_points, :given_to_user_id])
  end
end
