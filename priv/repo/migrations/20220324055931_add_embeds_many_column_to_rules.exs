defmodule Embeddy.Repo.Migrations.AddEmbedsManyColumnToRules do
  use Ecto.Migration

  def change do
    alter table(:rules) do
      add :conditions_multi, :map
    end
  end
end
