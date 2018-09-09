defmodule IssuesTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_into_descending_order: 1]

  test "greets the world" do
    assert Issues.hello() == :world
  end

  test "threee values returned if given three" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "sort in descending order" do
    res = sort_into_descending_order(fake_list(["c", "d", "a", "z", "m", "d"]))
    issues = for issue <- res, do: Map.get(issue, "created_at")

    assert issues == ~w{z m d d c a}
  end

  defp fake_list(values) do
    for val <- values, do: %{"created_at" => val, "other_data" => "blahblah"}
  end
end
