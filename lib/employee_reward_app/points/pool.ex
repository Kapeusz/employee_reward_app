defmodule EmployeeRewardApp.Points.Pool do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pools" do
    field :starting_points, :integer
    field :used_points, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(pool, attrs) do
    pool
    |> cast(attrs, [:starting_points, :used_points])
    |> validate_required([:starting_points, :used_points])
  end
end
