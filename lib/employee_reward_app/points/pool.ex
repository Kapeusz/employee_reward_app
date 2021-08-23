defmodule EmployeeRewardApp.Points.Pool do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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
  end

  def currently_points(id) do
    from(p in "pools",
    select: p.used_points,
    where: p.id == type(^id, :integer))
    |> Repo.all()
  end
end
