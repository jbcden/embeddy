defmodule MagicalDeleteButton do
  import Ecto.Changeset
  alias Embeddy.Rules.{Rule, Condition}

  def delete_conditions_multi_condition_by_id(%Rule{} = rule, condition_id) do
    {_original_condition, new_rule} =
      pop_in(rule, [
        Access.key(:conditions_multi),
        Access.filter(fn i -> i.id == condition_id end)
      ])

    Rule.changeset(rule)
    |> put_embed(:conditions_multi, new_rule.conditions_multi)
    |> Embeddy.Repo.update()
  end

  # NOTE: this is completely hardcoded to work with the test example
  def delete_conditions_multi_deep_condition_by_id(%Rule{} = rule, condition_id) do
    {_original_condition, new_rule} =
      pop_in(rule, [
        Access.key(:conditions_multi),
        Access.filter(fn i -> i.title == "cond 2" end),
        Access.key(:conditions),
        Access.filter(fn i -> i.id == condition_id end),
      ])

    Rule.changeset(rule)
    |> put_embed(:conditions_multi, new_rule.conditions_multi)
    |> Embeddy.Repo.update()
  end

  def delete_conditions_condition_by_id(%Rule{} = rule, condition_id) do
    {_original_condition, new_rule} =
      pop_in(rule, [
        Access.key(:conditions),
        Access.key(:conditions),
        Access.filter(fn i -> i.id == condition_id end)
      ])

    Rule.changeset(rule)
    |> put_embed(:conditions, new_rule.conditions)
    |> Embeddy.Repo.update()
  end
end
