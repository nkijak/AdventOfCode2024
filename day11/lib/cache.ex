defmodule RuleCache do
  use Agent

  def start() do
    Agent.start_link(fn -> %{0 => [1], 1 => [2024]} end, name: __MODULE__)
  end


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

  def get(k) do
    values = Agent.get(__MODULE__, &(Map.get(&1, k)))

    if values do
      values
    else
      #IO.puts("Missed #{k}")
      values = apply_rules(k)
      Agent.update(__MODULE__, &(Map.put(&1, k, values)))
      values
    end
  end

end
