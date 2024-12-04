defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @doc """
  Splits input line into array of the two ints

  ## Examples
      iex> Day1.parse("3  4")
      [3,4]
  """
  def parse(line) do
    line |> String.split |> Enum.map(fn i -> case Integer.parse(i), do: ({int, _} -> int) end)
  end

  def pick([], _) do
    []
  end

  def pick([next|nil], idx) do
    [Enum.at(next, idx)]
  end

  @doc """
  Picks the index for every sub list in matrix

  ## Examples
      iex> Day1.pick([[1,2],[3,4]], 0)
      [1,3]

      iex> Day1.pick([[1,2],[3,4]], 1)
      [2,4]
  """
  def pick([next|rest], idx) do
    [Enum.at(next, idx) | pick(rest, idx)]
  end



  @doc """
  Takes an N x 2 matrix and returns the 2 x N columns of values

  ## Examples
      iex> Day1.columns([[3,4],[5,6],[7,8]])
      [[3,5,7],[4,6,8]]
  """
  def columns(matrix) do
    0..1
    |> Enum.map(& pick(matrix, &1))
  end

  def diff({a,b}) do
    abs(a-b)
  end

  def sorted_columns(matrix) do
    columns(matrix) |> Enum.map(& Enum.sort/1)
  end

  @doc """
  Splits matrix into columns, sorts them, then diffs the rows, summing the total

  ## Examples
      iex> Day1.part1([[3,4],[4,3],[2,5],[1,3],[3,9],[3,3]])
      11
  """
  def part1(matrix) do
    [first, second] = sorted_columns(matrix)
    Enum.zip(first, second)
    |> Enum.map(& diff(&1))
    |> Enum.sum
  end

  @doc """
  calculates a "simularity score" by multiplying the left column number by the number of apperances
  in the right

  ## Examples
      iex> Day1.part2([[3,4],[4,3],[2,5],[1,3],[3,9],[3,3]])
      31
  """
  def part2(matrix) do
    [first, second] = sorted_columns(matrix)
    counts = second |> Enum.reduce(%{}, fn el, acc ->
      {_, counts} = Map.get_and_update(acc, el, fn el ->
        {el, (if el, do: el + 1, else: 1)}
      end)
      counts
    end)
    first |> Enum.map(& &1 * Map.get(counts, &1, 0)) |> Enum.sum
  end

  def main(_args) do
    {:ok, content} = File.read("input.txt")
    content
      |> String.split("\n")
      |> Enum.filter(fn l -> l != "" end)
      |> Enum.map(& parse/1)
      #|> part2
      |> tap(& &1 |> part1 |> IO.puts)
      |> tap(& &1 |> part2 |> IO.puts)
  end
end
