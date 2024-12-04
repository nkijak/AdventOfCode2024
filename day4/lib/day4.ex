defmodule Day4 do
  @moduledoc """
  Documentation for `tree4`.
  """

  def search(tree, _, _) when tree == nil do
    0
  end

  def search(tree, [n|[]], _) do
    IO.puts("last one #{n}")
    if tree.value == n do
      IO.puts("#{n} match")
      1
    else
      IO.puts("#{tree.value} - miss")
      0
    end
  end

  def search(tree, [n|r], dir) do
    IO.puts("with list")
    if tree.value == n do
      IO.puts("#{n} found. moving on")
      IO.puts("searching #{dir}")

      search(Map.get(tree,dir), r, dir)
    else
      0
    end
  end

end
