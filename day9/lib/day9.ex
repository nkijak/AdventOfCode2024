defmodule Day9 do
  @moduledoc """
  Documentation for `Day9`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day9.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  ## Example
      iex> Day9.checksum([0,0,9,9,8,1,1,1,8,8,8,2,7,7,7,3,3,3,6,4,4,6,5,5,5,5,6,6])
      1928
  """
  def checksum(blocks) do
    blocks
      |> Enum.with_index
      |> Enum.map(fn {el, i} -> el * i end)
      |> Enum.sum
  end

  @doc """
  ## Example
      iex> Day9.expand_and_id([2,3,3,3,1,3,3,1,2,1,4,1,4,1,3,1,4,0,2])
      [0,0,nil,nil,nil,1,1,1,nil,nil,nil,2,nil,nil,nil,3,3,3,nil,4,4,nil,5,5,5,5,nil,6,6,6,6,nil,7,7,7,nil,8,8,8,8,9,9]
  """
  def expand_and_id(dense) do
    dense
    |> Enum.chunk_every(2)
    |> Enum.with_index
    |> Enum.flat_map(fn {el, i} ->
      case el do
        [blocks] ->
            1..blocks |> Enum.map(fn _ -> i end)
        [blocks, 0] ->
            1..blocks |> Enum.map(fn _ -> i end)
        [blocks, free] ->
            b = 1..blocks |> Enum.map(fn _ -> i end)
            f = 1..free |> Enum.map(fn _ -> nil end)
            Enum.concat(b,f)
      end
    end)
  end



  @doc """
  ## Example
      iex> Day9.compact([0,nil,nil,1,1,1,nil,nil,nil,nil,2,2,2,2,2])
      [0,2,2,1,1,1,2,2,2,nil,nil,nil,nil,nil,nil]
  """
  def compact(expanded, free_start \\ 0, block_start \\ -1)

  def compact(expanded, free_start, block_start) when free_start < block_start or block_start == -1 do
    len = length(expanded)
    block_start = if block_start < 0, do: len - 1, else: block_start
    free = expanded
      |> Enum.slice(free_start, len)
      |> tap(& IO.inspect(&1))
      |> Enum.find_index(& &1 == nil)
    last_block = expanded
      |> Enum.reverse
      |> Enum.slice(len - block_start - 1, len)
      |> tap(& IO.inspect(&1))
      |> Enum.find_index(& &1 != nil)
    IO.puts("uncorrected Free=#{free} last_block=#{last_block}")
    free = free_start + free
    last_block = block_start - last_block
    value = Enum.at(expanded, last_block)
    IO.puts("Free=#{free} last_block=#{last_block} len=#{length(expanded)} value=#{value}")
    compact(expanded
      |> List.replace_at(free, value)
      |> List.replace_at(last_block, nil),
      free+1, last_block-1)
  end

  def compact(expanded, free_start , block_start) when free_start >= block_start do
    expanded
  end
end
