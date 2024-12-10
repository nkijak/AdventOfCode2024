defmodule Day9 do

  @doc """
  ## Example
      iex> Day9.checksum([0,0,9,9,8,1,1,1,8,8,8,2,7,7,7,3,3,3,6,4,4,6,5,5,5,5,6,6])
      1928
  """
  def checksum(blocks) do
    blocks
      |> Enum.with_index
      |> Enum.map(fn {el, i} ->
        (if el, do: el, else: 0) * i
      end)
      |> tap(& IO.inspect(&1))
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
    #|> tap(& &1 |> Enum.map(fn e -> if e == nil, do: ".", else: "#{e}" end) |> Enum.join |> IO.puts)
  end



  @doc """
  ## Example
      iex> Day9.compact([0,nil,nil,1,1,1,nil,nil,nil,nil,2,2,2,2,2])
      [0,2,2,1,1,1,2,2,2,nil,nil,nil,nil,nil,nil]
  """
  def compact(expanded, free_start \\ 0, block_start \\ -1)

  def compact(expanded, free_start, block_start) when free_start < block_start or block_start == -1 do
    #IO.puts("--- compact for #{free_start} from #{block_start}")
    #expanded |> Enum.map(fn e -> if e == nil, do: ".", else: "#{e}" end) |> Enum.join |> IO.puts
    len = length(expanded)
    block_start = if block_start < 0, do: len - 1, else: block_start
    free = expanded
      |> Enum.slice(free_start, len)
      #|> tap(& IO.inspect(&1))
      |> Enum.find_index(& &1 == nil)
    last_block = expanded
      |> Enum.reverse
      |> Enum.slice(len - block_start - 1, len)
      #|> tap(& IO.inspect(&1))
      |> Enum.find_index(& &1 != nil)
    #IO.puts("uncorrected Free=#{free} last_block=#{last_block}")
    free = free_start + free
    last_block = block_start - last_block
    value = Enum.at(expanded, last_block)
    IO.puts("moving #{value} from #{last_block} to #{free}")
    if last_block < free do
      expanded
    else
      compact(expanded
        |> List.replace_at(free, value)
        |> List.replace_at(last_block, nil),
        free, last_block-1)
    end
  end

  def compact(expanded, free_start , block_start) when free_start >= block_start and block_start > 0 do
    IO.puts("End of search free=#{free_start} block=#{block_start}")
    expanded |> Enum.map(fn e -> if e == nil, do: ".", else: "#{e}" end) |> Enum.join |> IO.puts
    expanded
  end

  @doc """
  ## Examples
      iex> Day9.parse("1234")
      [1,2,3,4]
  """
  def parse(line) do
    line |> String.codepoints |> Enum.map(fn c ->
      case Integer.parse(c) do
        {i, _}  -> i
        :error ->
          exit("Could not parse >#{c}<")
      end
    end)
  end

  @doc """
  ## Example
      iex> Day9.part1("2333133121414131402")
      1928
  """
  def part1(line) do
    line
    |> String.trim
    |> parse
    |> expand_and_id
    |> compact
    |> checksum
  end

  def main(_args) do
    {:ok, content} = File.read("input.txt")
    content
      |> tap(& &1 |> part1 |> IO.puts)
      #|> part2 |> IO.puts
  end
end
