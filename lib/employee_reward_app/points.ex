defmodule EmployeeRewardApp.Points do
  @moduledoc """
  The Points context.
  """

  import Ecto.Query, warn: false
  alias EmployeeRewardApp.Repo

  alias EmployeeRewardApp.Points.Pool
  alias EmployeeRewardApp.Points.GivenPoint


  @doc """
  Returns the list of pools.

  ## Examples

      iex> list_pools()
      [%Pool{}, ...]

  """
  def list_pools do
    Repo.all(Pool)
  end

  @doc """
  Gets a single pool.

  Raises `Ecto.NoResultsError` if the Pool does not exist.

  ## Examples

      iex> get_pool!(123)
      %Pool{}

      iex> get_pool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pool!(id), do: Repo.get!(Pool, id)

  @doc """
  Creates a pool.

  ## Examples

      iex> create_pool(%{field: value})
      {:ok, %Pool{}}

      iex> create_pool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pool(attrs \\ %{}) do
    %Pool{}
    |> Pool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pool.

  ## Examples

      iex> update_pool(pool, %{field: new_value})
      {:ok, %Pool{}}

      iex> update_pool(pool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pool(%Pool{} = pool, attrs) do
    pool
    |> Pool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pool.

  ## Examples

      iex> delete_pool(pool)
      {:ok, %Pool{}}

      iex> delete_pool(pool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pool(%Pool{} = pool) do
    Repo.delete(pool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pool changes.

  ## Examples

      iex> change_pool(pool)
      %Ecto.Changeset{data: %Pool{}}

  """
  def change_pool(%Pool{} = pool, attrs \\ %{}) do
    Pool.changeset(pool, attrs)
  end



  def reset_pools() do
    query = from p in EmployeeRewardApp.Points.Pool
    Repo.all(query)
    Repo.update_all(query,
    set: [
      starting_points: 50,
      used_points: 0
    ])
  end

  def insert_points(points, attrs) do
    points
    |> GivenPoint.changeset(attrs)
    |> Repo.insert()
  end
end
