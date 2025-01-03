defmodule Day11.Part2 do
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

  def process2(previous_counts) do
    Map.keys(previous_counts)
    |> Enum.reduce(%{}, fn prev_key, outer ->
      apply_rules(prev_key)
      |> Enum.reduce(outer, fn el, acc ->
        #IO.puts("     :#{el} #{inspect(acc)}")
        Map.update(acc, el, Map.get(previous_counts, prev_key, 0), &(&1 + 1))
      end)
      #|> tap(&(IO.puts("  end #{prev_key} #{inspect(&1)}")))
    end)
  end

  def parse(line) do
    line |> String.split |> Enum.map(fn s ->
      {int, _} = Integer.parse(s)
      int
    end)
  end

  def part(line, count) do
    initial = line
    |> parse
    |> Enum.reduce(%{}, fn el, acc ->
      Map.update(acc, el, 1, &(&1 + 1))
    end)
    #IO.puts("blink 0 #{inspect(initial)}")

    1..count
    |> Enum.reduce(initial, fn i, counts ->
      next = process2(counts)
      IO.puts("blink #{i} #{inspect(Map.keys(next))} #{inspect(next)}")
      next
    end)
    |> tap(& IO.inspect(&1))
    |> Map.values
    |> Enum.sum
  end

  def main() do
    "890 0 1 935698 68001 3441397 7221 27"
    |> tap(& IO.inspect(part(&1, 25)))
    |> part(75)
  end
end
