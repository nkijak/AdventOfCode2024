require Tqdm

defmodule Day11 do
  @moduledoc """
  This can probably be done much faster if a matrix is used or at least skip level (depth hunting?)
  0 -> 1 -> 2024 -> 20, 24 -> 20*2024(split), 24*2024(split), etc.
  So this look up table can be used to caluate once any 0s to any depth and they
  can then just insert into the final rows for any found.
  after removing all zeros, do actual rules on the rest of the row.
  move to next row, again do all the zero pre-computes, adding to the last row

  this _should_ remove a signifigant number of computations from the middle rows

  alternatively what if I made a process for each level and just sent the numbers for that level to calculate?
  every process has a reference to the next + the last level?
  """
  use Application

  def apply_rules(head) do
    headstr = "#{head}"
    splitable = rem(String.length(headstr), 2) == 0
    case head do
      0 -> [1]
      _ when splitable ->
        {l,r} = String.split_at(headstr, trunc(String.length(headstr)/2))
        Enum.map([l,r], fn x ->
          {i,_} = Integer.parse(x)
          i
        end)
      _ ->
        [head*2024]
    end
  end


  def rules([]) do
    IO.puts("END")
    []
  end

  #def rules([0|[]]) do
  #  #IO.puts("lastly, got a 0")
  #  [1]
  #end
  #def rules([0|tail]) do
  #  #IO.puts("got a 0")
  #  [1|rules(tail)]
  #end
  def rules([head|[]]) do
    #IO.puts("last element, #{head}")
    RuleCache.get(head)
  end
  def rules([head|tail]) do
    #IO.puts("applying to #{head}")
    rest = rules(tail)
    RuleCache.get(head) ++ rest
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
      iex> Day11.part2("125, 17", 24)
      55312
  """
  def part2(line, count) do
    chunk_size = 400
    initial = line |> parse
    0..count
    |> Tqdm.tqdm()
    |> Enum.reduce(initial, fn _, acc ->
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

  def rule_app(next, len) do
    #IO.puts("#{inspect(self())} start next->#{inspect(next)} len=#{len}")
    receive do
      {:rules, values} ->
        #IO.puts("#{inspect(self())} received rules #{inspect(values)}")
        nlength = len + length(values)
        Enum.each(values, fn r ->
          #IO.puts("#{inspect(self())} processing #{inspect(r)}")
          send(next,{:rules, rules([r])})
        end)
        #send(next, {:rules, rules(values)})
        if nlength != len do
          #IO.puts("looping #{inspect(self())}->#{inspect(next)}")
          rule_app(next, nlength)
        end
        #IO.puts("#{inspect(self())} exiting len=#{len} nlen=#{nlength}")
      :done ->
        send(next, :done)
        IO.puts("#{inspect(self())} DONE")
    end
  end

  def process_part(count) do
    line = "890 0 1 935698 68001 3441397 7221 27"
    process_part(line, count)
  end

  def count_up(curr_len \\ 0) do
    receive do
      {:rules, vals} -> count_up(curr_len + length(vals))
      :done -> IO.puts("TOTAL COUNT: #{curr_len}")
    end
  end

  @spec process_part(integer()) :: any()
  def process_part(line, count) do
    initial = line |> parse
    last = 1..count
      |> Enum.reduce(self(),
        fn _, acc ->
          spawn_link(fn -> rule_app(acc, 0) end)
        end)
    send(last, {:rules, initial})
    send(last, :done)
    count_up()
  end

  @doc """
      iex> Day11.part("125, 17", 24)
      55312
  """
  def part(line, count) do
    initial = line |> parse
    0..count
    |> Tqdm.tqdm()
    |> Enum.reduce(initial, fn _, acc ->
      rules(acc)
    end)
    |> length
  end

  def start(_type, _args) do
    IO.puts("self #{inspect(self())}")
    {:ok, _} = RuleCache.start()
    "890 0 1 935698 68001 3441397 7221 27"
    |> process_part(75)
      # |> tap(& &1 |> part(24) |> IO.puts)
      # |> part(74) |> IO.puts
  end
end
