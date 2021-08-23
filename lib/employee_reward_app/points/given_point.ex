defmodule EmployeeRewardApp.Points.GivenPoint do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias EmployeeRewardApp.Repo

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
    |> validate_given_user_id()
  end

  defp validate_given_user_id(changeset) do
    user_id = get_field(changeset, :user_id)
    given_to_user_id = get_field(changeset, :given_to_user_id)

    if(user_id == given_to_user_id) do
      message = "You can't give points to yourself."
      add_error(changeset, given_to_user_id, message, to_field: given_to_user_id)
    else
      changeset
    end
  end
end
