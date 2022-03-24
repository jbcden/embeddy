defmodule Embeddy.Rules do
  @moduledoc false
  alias Embeddy.Rules.Rule
  alias Embeddy.Repo

  def create_rule(attrs \\ %{}) do
    %Rule{}
    |> Rule.changeset(attrs)
    |> Repo.insert()
  end

  def update_rule(%Rule{} = rule, attrs \\ %{}) do
    rule
    |> Rule.changeset(attrs)
    |> Repo.update()
  end
end
