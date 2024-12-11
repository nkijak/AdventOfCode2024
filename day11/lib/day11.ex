require Tqdm

defmodule Day11 do
  def apply_rules(head) do
    headstr = "#{head}"
    if rem(String.length(headstr), 2) == 0 do
      {l,r} = String.split_at(headstr, trunc(String.length(headstr)/2))
      Enum.map([l,r], fn x ->
        {i,_} = Integer.parse(x)
        i
      end)
    else
      [head*2024]
    end
  end

  def rules([]) do
    []
  end

  def rules([0|[]]) do
    #IO.puts("lastly, got a 0")
    [1]
  end
  def rules([0|tail]) do
    #IO.puts("got a 0")
    [1| rules(tail)]
  end
  def rules([head|[]]) do
    #IO.puts("last element, #{head}")
    apply_rules(head)
  end
  def rules([head|tail]) do
    #IO.puts("applying to #{head}")
    apply_rules(head) ++ rules(tail)
  end


  @doc """
      iex> Day11.parse("890 0 1 935698 68001 3441397 7221 27")
      [890,0,1,935698,68001,3441397,7221,27]
  """
  def parse(line) do
    line |> String.split |> Enum.map(fn s ->
      {int, _} = Integer.parse(s)
      int
    end)
  end

  @doc """
      iex> Day11.part("125, 17", 24)
      55312
  """
  def part(line, count) do
    chunk_size = 400
    initial = line |> parse
    0..count
    |> Tqdm.tqdm()
    |> Enum.reduce(initial, fn i, acc ->
      parts = trunc(length(acc) / chunk_size)
      IO.puts("parts #{parts}")
      0..parts
        |> Enum.map(fn p ->
          Enum.slice(acc, p*chunk_size, chunk_size)
        end)
        |> Task.async_stream(fn slice -> rules(slice) end, ordered: false, max_concurrency: 8, timeout: 400)
        |> Enum.reduce([], fn {:ok, el}, total_list ->
          total_list ++ el
        end)
    end)
    |> length
  end

  def main(_args) do
    "890 0 1 935698 68001 3441397 7221 27"
      |> tap(& &1 |> part(24) |> IO.puts)
      |> part(74) |> IO.puts
  end
end
