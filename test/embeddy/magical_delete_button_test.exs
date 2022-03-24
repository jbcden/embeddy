defmodule MagicalDeleteButtonTest do
  use Embeddy.DataCase
  alias Embeddy.Rules

  test "with embeds_many" do
    {:ok, rule_1} =
      Rules.create_rule(%{
        name: "my cool rule",
        description: "Let's delete some conditions",
        conditions_multi: [
          %{title: "cond 1", bar: "> 123"},
          %{title: "cond 2", bar: "< 99"}
        ],
        conditions: []
      })

    condition_to_remove_id =
      get_in(rule_1.conditions_multi, [
        Access.filter(fn i -> i.title == "cond 1" end),
        Access.key(:id)
      ])
      |> List.first()

    {:ok, rule_1} =
      rule_1
      |> MagicalDeleteButton.delete_conditions_multi_condition_by_id(condition_to_remove_id)

    assert nil ==
             get_in(rule_1.conditions_multi, [
               Access.filter(fn i -> i.title == "cond 1" end),
               Access.key(:id)
             ])
             |> List.first()
  end

  @tag :skip
  test "with embeds_many deep nesting" do
    {:ok, rule_1} =
      Rules.create_rule(%{
        name: "my cool rule",
        description: "Let's delete some conditions",
        conditions_multi: [
          %{title: "cond 1", bar: "> 123"},
          %{title: "cond 2", bar: "< 99", conditions: [
            %{title: "nested cond", bar: "nest"}
          ]}
        ],
        conditions: []
      })

    condition_to_remove_id =
      get_in(rule_1.conditions_multi, [
        Access.filter(fn i -> i.title == "cond 2" end),
        Access.key(:conditions),
        Access.filter(fn i -> i.title == "nested cond" end),
        Access.key(:id),
      ])
      |> List.flatten()
      |> List.first()

    {:ok, rule_1} =
      rule_1
      |> MagicalDeleteButton.delete_conditions_multi_deep_condition_by_id(condition_to_remove_id)

    assert nil ==
             get_in(rule_1.conditions_multi, [
               Access.filter(fn i -> i.title == "cond 2" end),
               Access.key(:conditions),
               Access.filter(fn i -> i.title == "nested cond" end),
               Access.key(:id)
             ])
             |> List.first()
  end

  test "with embeds_one" do
    {:ok, rule_1} =
      Rules.create_rule(%{
        name: "my cool rule",
        description: "Let's delete some conditions",
        conditions: %{
          title: "Top-level",
          bar: "baz",
          conditions: [
            %{title: "cond 1", bar: "> 123"},
            %{title: "cond 2", bar: "< 99"}
          ]
        }
      })

    condition_to_remove_id =
      get_in(rule_1.conditions, [
        Access.key(:conditions),
        Access.filter(fn i -> i.title == "cond 1" end),
        Access.key(:id)
      ])
      |> List.first()

    {:ok, rule_1} =
      rule_1
      |> MagicalDeleteButton.delete_conditions_condition_by_id(condition_to_remove_id)

    assert nil ==
             get_in(rule_1.conditions, [
               Access.key(:conditions),
               Access.filter(fn i -> i.title == "cond 1" end),
               Access.key(:id)
             ])
             |> List.first()
  end
end
