defmodule Api.RevenuesTest do
  use Api.DataCase

  alias Api.Revenues

  describe "revenues" do
    alias Api.Revenues.Revenue

    @valid_attrs %{
      category: "some category",
      client: "some client",
      description: "some description",
      payday: "some payday",
      status: "some status",
      value: "some value"
    }
    @update_attrs %{
      category: "some updated category",
      client: "some updated client",
      description: "some updated description",
      payday: "some updated payday",
      status: "some updated status",
      value: "some updated value"
    }
    @invalid_attrs %{
      category: nil,
      client: nil,
      description: nil,
      payday: nil,
      status: nil,
      value: nil
    }

    def revenue_fixture(attrs \\ %{}) do
      {:ok, revenue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Revenues.create_revenue()

      revenue
    end

    test "list_revenues/0 returns all revenues" do
      revenue = revenue_fixture()
      assert Revenues.list_revenues() == [revenue]
    end

    test "get_revenue!/1 returns the revenue with given id" do
      revenue = revenue_fixture()
      assert Revenues.get_revenue!(revenue.id) == revenue
    end

    test "create_revenue/1 with valid data creates a revenue" do
      assert {:ok, %Revenue{} = revenue} = Revenues.create_revenue(@valid_attrs)
      assert revenue.category == "some category"
      assert revenue.client == "some client"
      assert revenue.description == "some description"
      assert revenue.payday == "some payday"
      assert revenue.status == "some status"
      assert revenue.value == "some value"
    end

    test "create_revenue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Revenues.create_revenue(@invalid_attrs)
    end

    test "update_revenue/2 with valid data updates the revenue" do
      revenue = revenue_fixture()
      assert {:ok, %Revenue{} = revenue} = Revenues.update_revenue(revenue, @update_attrs)
      assert revenue.category == "some updated category"
      assert revenue.client == "some updated client"
      assert revenue.description == "some updated description"
      assert revenue.payday == "some updated payday"
      assert revenue.status == "some updated status"
      assert revenue.value == "some updated value"
    end

    test "update_revenue/2 with invalid data returns error changeset" do
      revenue = revenue_fixture()
      assert {:error, %Ecto.Changeset{}} = Revenues.update_revenue(revenue, @invalid_attrs)
      assert revenue == Revenues.get_revenue!(revenue.id)
    end

    test "delete_revenue/1 deletes the revenue" do
      revenue = revenue_fixture()
      assert {:ok, %Revenue{}} = Revenues.delete_revenue(revenue)
      assert_raise Ecto.NoResultsError, fn -> Revenues.get_revenue!(revenue.id) end
    end

    test "change_revenue/1 returns a revenue changeset" do
      revenue = revenue_fixture()
      assert %Ecto.Changeset{} = Revenues.change_revenue(revenue)
    end
  end
end
