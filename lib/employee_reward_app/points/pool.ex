defmodule EmployeeRewardApp.Points.Pool do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pools" do
    field :starting_points, :integer
    field :used_points, :integer
    belongs_to :user, EmployeeRewardApp.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(pool, attrs) do
    pool
    |> cast(attrs, [:starting_points, :used_points, :user_id])
    |> validate_required([:starting_points])
    |> foreign_key_constraint(:user_id, message: "User not found!")
  end
end
