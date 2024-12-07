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

  def build(this, previous_tree) do
    %Tree{value: this, right: previous_tree}
  end

  def parse(line) do
    line
    |> String.split("")
    |> Enum.filter(& &1 != "")
    |> Enum.reverse() # ["C","B", "A"]
    |> Enum.chunk_every(2)
  end

  @spec link(any(), any()) :: list()
  def link(lineA, lineB) do
    lineA
    |> Enum.with_index
    |> Enum.map(fn {el, idx} ->
      right = if idx+1 >= length(lineA), do: nil, else: Enum.at(lineA, idx+1)
      corner = if idx+1 >= length(lineB), do: nil, else: Enum.at(lineB, idx+1)
      down = Enum.at(lineB, idx)
      %{el|right: right, down: down, corner: corner}
    end)
  end

end
