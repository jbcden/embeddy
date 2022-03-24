defmodule Embeddy.Rules.Condition do
  use Ecto.Schema

  import Ecto.Changeset

  alias Embeddy.Rules.Condition

  @moduledoc false

  embedded_schema do
    field :title
    field :bar
    embeds_many :conditions, Condition, on_replace: :delete
  end

  def changeset(%Condition{} = condition, attrs = %{}) do
    condition
    |> cast(attrs, [:title, :bar])
    |> cast_embed(:conditions)
  end
end
