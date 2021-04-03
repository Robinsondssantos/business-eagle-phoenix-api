defmodule Api.Revenues.Revenue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "revenues" do
    field :category, :string
    field :client, :string
    field :description, :string
    field :payday, :float
    field :status, :string
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(revenue, attrs) do
    revenue
    |> cast(attrs, [:description, :client, :category, :payday, :value, :status])
    |> validate_required([:description, :client, :category, :payday, :value, :status])
  end
end
