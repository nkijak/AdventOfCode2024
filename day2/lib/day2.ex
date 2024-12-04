defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day2.hello()
      :world

  """
  def hello do
    :world
  end

  def parse(line) do
    line |> String.split |> Enum.map(fn i -> case Integer.parse(i), do: ({int, _} -> int) end)
  end

  @doc """
  returns the neighboring values difference

  ## Examples
      iex> Day2.diffs([7,6,4,2,1])
      [1, 2, 2, 1]
  """
  def diffs(record) do
    record
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a,b] -> a - b end)
  end

  @doc """
  ## Example
      iex> Day2.dampened_all?([1,2,1], true, -1, fn i -> i==1 end)
      {true, 1}
      iex> Day2.dampened_all?([1,2,2], true, -1, fn i -> i==1 end)
      {false, 1}
      iex> Day2.dampened_all?([1,2,1], true, 1, fn i -> i==1 end)
      {true, 1}
  """
  def dampened_all?(enumerable, dampen, idx, fun) do
    IO.puts("...")
    {_, all, idx} = enumerable
      |> Enum.map(fun)
      |> Enum.with_index
      |> tap(& IO.inspect(&1))
      |> Enum.reduce({dampen, true, idx}, fn {el, curr_idx}, {d, ir, oidx} ->
          IO.puts("el=#{el}, idx=#{curr_idx}, damper=#{d}, ir=#{ir}, index to watch=#{oidx}")
          case {d,el,oidx == -1, oidx == curr_idx} do
            {true, false, true, _} -> {false, ir, curr_idx}
            {true, false, false, true} -> {d, ir, curr_idx}
            {true, false, false, false} -> {false, false, curr_idx}
            {false, false, true, _} -> {false, false, curr_idx}
            {false, false, false, _} -> {false, false, oidx}
            {_, true, _, _} -> {d, ir, oidx}
          end
        end)
    {all, idx}
  end

  @doc """
  Termines business rules for safe records

  ## Examples
      iex> Day2.safe([1, 2, 2, 1])
      true
      iex> Day2.safe([-1,-5,-1,-1])
      false
      iex> Day2.safe([-1,-5,-1,-1], true)
      true
      iex> Day2.safe([-1, -5, -1, -1], true)
      true
      iex> Day2.safe([-1,-2,-2,-1])
      true
      iex> Day2.safe([1,5,2,1], true)
      true
      iex> Day2.safe([1,5,-2,1], true)
      false
  """
  def safe(record_diffs, dampen \\ false) do
    IO.inspect(record_diffs)
    IO.puts("in_range")
    {in_range, ridx} = record_diffs
      |> dampened_all?(dampen, -1, fn i -> i <= 3 and i >= -3 and i != 0 end)
    IO.puts("asc")
    {asc, aidx} = record_diffs
      |> dampened_all?(dampen, ridx, fn i -> i < 0 end)
    IO.puts("desc")
    {desc,_} = record_diffs
      |> dampened_all?(dampen, aidx, fn i -> i > 0 end)
    IO.puts("---")
    IO.puts("in_range=#{in_range}, asc=#{asc}, desc=#{desc}")
    IO.puts("")
    in_range and (desc or asc)
  end

  @doc """
  counts the number of safe records

  ## Example
      iex> Day2.part1([[7,6,4,2,1], [1,2,7,8,9], [9,7,6,2,1], [1,3,2,4,5], [8,6,4,4,1], [1,3,6,7,9]])
      2
  """
  def part1(records) do
    records |> Enum.map(fn r ->
      r |> diffs |> safe
    end)
    |> Enum.count(& &1)
  end

  @doc """
  counts the number of safe records

  ## Example
      iex> Day2.part2([[7,6,4,2,1], [1,2,7,8,9], [9,7,6,2,1], [1,3,2,4,5], [8,6,4,4,1], [1,3,6,7,9]])
      4
  """
  def part2(records) do
    records |> Enum.map(fn r ->
      r |> diffs |> safe(true)
    end) |> Enum.count(& &1)
  end

  def main(_args) do
    {:ok, content} = File.read("input.txt")
    content
      |> String.split("\n")
      |> Enum.filter(fn l -> l != "" end)
      |> Enum.map(& parse/1)
      #|> part2
      |> tap(& &1 |> part1 |> IO.puts)
      #|> tap(& &1 |> part2 |> IO.puts)
  end
end
