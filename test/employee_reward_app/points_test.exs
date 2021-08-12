defmodule EmployeeRewardApp.PointsTest do
  use EmployeeRewardApp.DataCase

  alias EmployeeRewardApp.Points

  describe "pools" do
    alias EmployeeRewardApp.Points.Pool

    @valid_attrs %{starting_points: 42, used_points: 42}
    @update_attrs %{starting_points: 43, used_points: 43}
    @invalid_attrs %{starting_points: nil, used_points: nil}

    def pool_fixture(attrs \\ %{}) do
      {:ok, pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Points.create_pool()

      pool
    end

    test "list_pools/0 returns all pools" do
      pool = pool_fixture()
      assert Points.list_pools() == [pool]
    end

    test "get_pool!/1 returns the pool with given id" do
      pool = pool_fixture()
      assert Points.get_pool!(pool.id) == pool
    end

    test "create_pool/1 with valid data creates a pool" do
      assert {:ok, %Pool{} = pool} = Points.create_pool(@valid_attrs)
      assert pool.starting_points == 42
      assert pool.used_points == 42
    end

    test "create_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Points.create_pool(@invalid_attrs)
    end

    test "update_pool/2 with valid data updates the pool" do
      pool = pool_fixture()
      assert {:ok, %Pool{} = pool} = Points.update_pool(pool, @update_attrs)
      assert pool.starting_points == 43
      assert pool.used_points == 43
    end

    test "update_pool/2 with invalid data returns error changeset" do
      pool = pool_fixture()
      assert {:error, %Ecto.Changeset{}} = Points.update_pool(pool, @invalid_attrs)
      assert pool == Points.get_pool!(pool.id)
    end

    test "delete_pool/1 deletes the pool" do
      pool = pool_fixture()
      assert {:ok, %Pool{}} = Points.delete_pool(pool)
      assert_raise Ecto.NoResultsError, fn -> Points.get_pool!(pool.id) end
    end

    test "change_pool/1 returns a pool changeset" do
      pool = pool_fixture()
      assert %Ecto.Changeset{} = Points.change_pool(pool)
    end
  end
end
