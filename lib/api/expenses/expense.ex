defmodule Api.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :category, :string
    field :description, :string
    field :payday, :float
    field :provider, :string
    field :status, :string
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:description, :provider, :category, :payday, :value, :status])
    |> validate_required([:description, :provider, :category, :payday, :value, :status])
  end
end
