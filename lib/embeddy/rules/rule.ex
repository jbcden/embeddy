defmodule Embeddy.Rules.Rule do
  use Ecto.Schema

  alias Embeddy.Rules.{Rule, Condition}
  import Ecto.Changeset

  schema "rules" do
    field :name, :string
    field :description, :string
    embeds_one :conditions, Condition, on_replace: :delete
    embeds_many :conditions_multi, Condition, on_replace: :delete

    timestamps()
  end

  def changeset(%Rule{} = rule, attrs \\ %{}) do
    rule
    |> cast(attrs, [:name, :description])
    |> cast_embed(:conditions)
    |> cast_embed(:conditions_multi)
  end
end
