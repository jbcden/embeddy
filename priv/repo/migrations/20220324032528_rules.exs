defmodule Embeddy.Repo.Migrations.Rules do
  use Ecto.Migration

  def change do
    create table(:rules) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :conditions, :map
      timestamps(type: :utc_datetime)
    end
  end
end
