defmodule EmployeeRewardApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  alias EmployeeRewardApp.Repo

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :password_digest, :string
    belongs_to :role, EmployeeRewardApp.Role
    has_one :pool, EmployeeRewardApp.Points.Pool, on_delete: :delete_all
    has_many :given_points, EmployeeRewardApp.Points.GivenPoint, foreign_key: :user_id, on_delete: :delete_all
    timestamps()
    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:full_name, :email, :password, :password_confirmation, :role_id])
    |> validate_required([:full_name, :email, :password, :password_confirmation, :role_id])
    |> cast_assoc(:pool)
    |> validate_password()
    |> unique_constraint(:email)
    |> validate_length(:full_name, min: 3)
    |> hash_password
  end

  defp validate_password(changeset) do
    changeset
    |> validate_no_repetitive_characters()
    |> validate_no_sequential_characters()
  end

  defp validate_no_repetitive_characters(changeset) do
    Ecto.Changeset.validate_change(changeset, :password, fn :password, password ->
      case repetitive_characters?(password) do
        true -> [password: "has repetitive characters"]
        false -> []
      end
    end)
  end

  defp repetitive_characters?(password) when is_binary(password) do
    password
    |> String.to_charlist()
    |> repetitive_characters?()
  end

  defp repetitive_characters?([c, c, c | _rest]), do: true
  defp repetitive_characters?([_c | rest]), do: repetitive_characters?(rest)
  defp repetitive_characters?([]), do: false

  defp validate_no_sequential_characters(changeset) do
    Ecto.Changeset.validate_change(changeset, :password, fn :password, password ->
      case sequential_characters?(password) do
        true -> [password: "has sequential characters"]
        false -> []
      end
    end)
  end

  @sequences ["01234567890", "abcdefghijklmnopqrstuvwxyz"]
  @max_sequential_chars 3

  defp sequential_characters?(password) do
    Enum.any?(@sequences, &sequential_characters?(password, &1))
  end

  defp sequential_characters?(password, sequence) do
    max = String.length(sequence) - 1 - @max_sequential_chars

    Enum.any?(0..max, fn x ->
      pattern = String.slice(sequence, x, @max_sequential_chars + 1)

      String.contains?(password, pattern)
    end)
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end

  # def given_to_user_email(id) do
  #   from(u in "users",
  #   select: %{email: u.email},
  #   where: u.id == type(^id, :integer))
  #   |> Repo.all()
  # end
end
