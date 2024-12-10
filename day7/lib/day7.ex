defmodule Day7 do
  defstruct [:answer, :input]

  @doc """
  ## Example
      iex> Day7.parse("190: 10 19")
      %Day7{answer: 190, input: [10,19]}
  """
  def parse(line) do
    [raw_answer, raw_input] = line |> String.split(":")
    inputs = raw_input
      |> String.split
      |> Enum.map(& case Integer.parse(&1) do {int, _} -> int end)
    {answer, _} = Integer.parse(raw_answer)
    %Day7{answer: answer, input: inputs}
  end


  def leaf_calc(op, answer, left, right) do
    value = case op do
      :multiply -> left * right
      :add -> left + right
      :concat ->
        {i, _} = Integer.parse("#{left}#{right}")
        i
    end
    IO.puts("leaf calulation #{left} #{op} #{right} == #{answer}?")
    value == answer
  end


  def continue(answer, acc, [right|[]], ops) do
    #IO.puts("last values to #{answer} with #{acc}, #{right}")
    #IO.inspect(ops)
    ops |> Enum.map(& leaf_calc(&1, answer, acc, right)) |> Enum.any?
  end

  def continue(answer, acc, [right|rest], ops) do
    ops |> Enum.map(fn op ->
      value = case op do
        :multiply -> acc * right
        :add -> acc + right
        :concat ->
          {i, _} = Integer.parse("#{acc}#{right}")
          i
      end
      #IO.puts("continuing to #{answer} with #{acc} #{op} #{right} = #{value}")
      continue(answer, value, rest, ops)
    end)
    |> Enum.any?
  end

  def start(d, ops) do
    [s|tail] = d.input
    if continue(d.answer, s, tail, ops) do
      d.answer
    else
      0
    end
  end



  def part1(lines) do
    lines
    |> Enum.map(& parse(&1))
    |> Enum.map(& start(&1, [:multiply, :add]))
    |> tap(& IO.inspect(&1))
    |> Enum.sum
  end

  def part2(lines) do
    lines
    |> Enum.map(& parse(&1))
    |> Enum.map(& start(&1, [:multiply, :add, :concat]))
    |> tap(& IO.inspect(&1))
    |> Enum.sum
  end

  def main(_args) do
    {:ok, content} = File.read("input.txt")
    content
      |> String.split("\n")
      |> Enum.filter(fn l -> l != "" end)
      #|> tap(& &1 |> part1 |> IO.puts)
      |> part2 |> IO.puts
  end
end
