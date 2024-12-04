defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.

  xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
  161
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day3.hello()
      :world

  """
  def hello do
    :world
  end

  def loop([next]) do
    case next do
      [_, "do"] -> [true]
      [_, "don't", _] -> [false]
      [_,_,_,a,b] -> [{a,b}]
    end
  end

  @doc """
  ## Examples
      iex> Day3.loop([["do()","do"], ["mul(5,5)","","","5","5"]])
      [true, {"5","5"}]
      iex> Day3.loop([["do()","do"], ["mul(5,5)","","","5","5"]])
      [true, {"5","5"}]
      iex> Day3.loop([["don't()","don't", "n't"], ["mul(5,5)","","","5","5"]])
      [false, {"5","5"}]
  """
  def loop([next | rest]) do
    case next do
      [_, "do"] -> [true | loop(rest)]
      [_, "don't", _] -> [false | loop(rest)]
      [_,_,_,a,b] -> [{a,b}|loop(rest)]
    end
  end

  @doc """
  ## Example
      iex> Day3.parse_cond("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
      [{2,4}, false, {5,5}, {11,8}, true, {8,5}]
  """
  def parse_cond(line) do
    Regex.scan(~r/(do(n't)*)\(\)|mul\((\d+),(\d+)\)/, line)
    |> loop
    |> Enum.map(fn next ->
      case next do
        {a, b} ->
          {x, _} = Integer.parse(a)
          {y, _} = Integer.parse(b)
          {x,y}
        bool -> bool
      end
    end)
  end

  @doc """
  ## Example
      iex> Day3.parse("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
      [{2,4}, {5,5}, {11,8}, {8,5}]
  """
  def parse(line) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, line)
    |> Enum.map(fn [_,a,b] ->
      {x, _} = Integer.parse(a)
      {y, _} = Integer.parse(b)
      {x,y}
    end)
  end

  @doc """
  ## Examples
      iex> Day3.part1(["mul(2,2)+mul(3,3)", "mul(2,3)"])
      19
  """
  def part1(lines) do
    lines
    |> Enum.flat_map(& parse(&1))
    |> Enum.map(fn {a,b} -> a*b end)
    |> Enum.sum
  end

  def filter([last], enabled) do
    if enabled do
      [last]
    else
      []
    end
  end

  @doc """
  ## Example
      iex> Day3.filter([{1,1}, false, {2,2}, {3,3}, true, {4,4}], true)
      [{1,1}, {4,4}]
  """
  def filter([next|rest], enabled) do
    case next do
      {a,b} ->
        if enabled do
          [{a,b} | filter(rest, enabled)]
        else
          filter(rest, enabled)
        end
      bool ->
        filter(rest, bool)
    end
  end

  @doc """
  ## Examples
      iex> Day3.part2(["xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))", "don't()", "mul(5,5)"])
      48
  """
  def part2(lines) do
    lines
    |> Enum.flat_map(& parse_cond(&1))
    |> filter(true)
    |> Enum.map(fn {a,b} -> a*b end)
    |> Enum.sum
  end

  def main(_args) do
    {:ok, content} = File.read("input.txt")
    content
      |> String.split("\n")
      |> Enum.filter(fn l -> l != "" end)
      |> tap(& &1 |> part1 |> IO.puts)
      |> part2 |> IO.puts
  end
end
