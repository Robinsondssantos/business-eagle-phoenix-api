defmodule ApiWeb.RevenueControllerTest do
  use ApiWeb.ConnCase

  alias Api.Revenues
  alias Api.Revenues.Revenue

  @create_attrs %{
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

  def fixture(:revenue) do
    {:ok, revenue} = Revenues.create_revenue(@create_attrs)
    revenue
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all revenues", %{conn: conn} do
      conn = get(conn, Routes.revenue_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create revenue" do
    test "renders revenue when data is valid", %{conn: conn} do
      conn = post(conn, Routes.revenue_path(conn, :create), revenue: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.revenue_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => "some category",
               "client" => "some client",
               "description" => "some description",
               "payday" => "some payday",
               "status" => "some status",
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.revenue_path(conn, :create), revenue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update revenue" do
    setup [:create_revenue]

    test "renders revenue when data is valid", %{conn: conn, revenue: %Revenue{id: id} = revenue} do
      conn = put(conn, Routes.revenue_path(conn, :update, revenue), revenue: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.revenue_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => "some updated category",
               "client" => "some updated client",
               "description" => "some updated description",
               "payday" => "some updated payday",
               "status" => "some updated status",
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, revenue: revenue} do
      conn = put(conn, Routes.revenue_path(conn, :update, revenue), revenue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete revenue" do
    setup [:create_revenue]

    test "deletes chosen revenue", %{conn: conn, revenue: revenue} do
      conn = delete(conn, Routes.revenue_path(conn, :delete, revenue))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.revenue_path(conn, :show, revenue))
      end
    end
  end

  defp create_revenue(_) do
    revenue = fixture(:revenue)
    %{revenue: revenue}
  end
end
