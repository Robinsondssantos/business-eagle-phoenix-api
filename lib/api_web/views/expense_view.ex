defmodule ApiWeb.ExpenseView do
  use ApiWeb, :view
  alias ApiWeb.ExpenseView

  def render("index.json", %{expenses: expenses}) do
    %{data: render_many(expenses, ExpenseView, "expense.json")}
  end

  def render("show.json", %{expense: expense}) do
    %{data: render_one(expense, ExpenseView, "expense.json")}
  end

  def render("expense.json", %{expense: expense}) do
    %{
      id: expense.id,
      description: expense.description,
      provider: expense.provider,
      category: expense.category,
      payday: expense.payday,
      value: expense.value,
      status: expense.status
    }
  end
end
