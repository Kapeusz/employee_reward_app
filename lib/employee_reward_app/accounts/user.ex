defmodule EmployeeRewardApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :password_digest, :string

    timestamps()
    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:full_name, :email, :password, :password_confirmation])
    |> validate_required([:full_name, :email, :password, :password_confirmation])
    |> hash_password
  end

  #hash password for test
  # defp hash_password(changeset) do
  #   changeset
  #   |> put_change(:password_digest, "ABCDE")
  # end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
