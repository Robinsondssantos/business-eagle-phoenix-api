defmodule ApiWeb.ExpenseControllerTest do
  use ApiWeb.ConnCase

  alias Api.Expenses
  alias Api.Expenses.Expense

  @create_attrs %{
    category: "some category",
    description: "some description",
    payday: "some payday",
    provider: "some provider",
    status: "some status",
    value: "some value"
  }
  @update_attrs %{
    category: "some updated category",
    description: "some updated description",
    payday: "some updated payday",
    provider: "some updated provider",
    status: "some updated status",
    value: "some updated value"
  }
  @invalid_attrs %{category: nil, description: nil, payday: nil, provider: nil, status: nil, value: nil}

  def fixture(:expense) do
    {:ok, expense} = Expenses.create_expense(@create_attrs)
    expense
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all expenses", %{conn: conn} do
      conn = get(conn, Routes.expense_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create expense" do
    test "renders expense when data is valid", %{conn: conn} do
      conn = post(conn, Routes.expense_path(conn, :create), expense: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.expense_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => "some category",
               "description" => "some description",
               "payday" => "some payday",
               "provider" => "some provider",
               "status" => "some status",
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.expense_path(conn, :create), expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update expense" do
    setup [:create_expense]

    test "renders expense when data is valid", %{conn: conn, expense: %Expense{id: id} = expense} do
      conn = put(conn, Routes.expense_path(conn, :update, expense), expense: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.expense_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => "some updated category",
               "description" => "some updated description",
               "payday" => "some updated payday",
               "provider" => "some updated provider",
               "status" => "some updated status",
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, expense: expense} do
      conn = put(conn, Routes.expense_path(conn, :update, expense), expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete expense" do
    setup [:create_expense]

    test "deletes chosen expense", %{conn: conn, expense: expense} do
      conn = delete(conn, Routes.expense_path(conn, :delete, expense))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.expense_path(conn, :show, expense))
      end
    end
  end

  defp create_expense(_) do
    expense = fixture(:expense)
    %{expense: expense}
  end
end
