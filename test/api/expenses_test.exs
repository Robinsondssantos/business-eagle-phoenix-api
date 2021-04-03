defmodule Api.ExpensesTest do
  use Api.DataCase

  alias Api.Expenses

  describe "expenses" do
    alias Api.Expenses.Expense

    @valid_attrs %{category: "some category", description: "some description", payday: "some payday", provider: "some provider", status: "some status", value: "some value"}
    @update_attrs %{category: "some updated category", description: "some updated description", payday: "some updated payday", provider: "some updated provider", status: "some updated status", value: "some updated value"}
    @invalid_attrs %{category: nil, description: nil, payday: nil, provider: nil, status: nil, value: nil}

    def expense_fixture(attrs \\ %{}) do
      {:ok, expense} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Expenses.create_expense()

      expense
    end

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Expenses.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Expenses.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      assert {:ok, %Expense{} = expense} = Expenses.create_expense(@valid_attrs)
      assert expense.category == "some category"
      assert expense.description == "some description"
      assert expense.payday == "some payday"
      assert expense.provider == "some provider"
      assert expense.status == "some status"
      assert expense.value == "some value"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{} = expense} = Expenses.update_expense(expense, @update_attrs)
      assert expense.category == "some updated category"
      assert expense.description == "some updated description"
      assert expense.payday == "some updated payday"
      assert expense.provider == "some updated provider"
      assert expense.status == "some updated status"
      assert expense.value == "some updated value"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_expense(expense, @invalid_attrs)
      assert expense == Expenses.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Expenses.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Expenses.change_expense(expense)
    end
  end
end
