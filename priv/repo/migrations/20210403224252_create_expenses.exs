defmodule Api.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :description, :string
      add :provider, :string
      add :category, :string
      add :payday, :float
      add :value, :string
      add :status, :string

      timestamps()
    end

  end
end
