defmodule Api.Repo.Migrations.CreateRevenues do
  use Ecto.Migration

  def change do
    create table(:revenues) do
      add :description, :string
      add :client, :string
      add :category, :string
      add :payday, :float
      add :value, :string
      add :status, :string

      timestamps()
    end

  end
end
