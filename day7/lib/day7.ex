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

  # last inputs, breath of operations
  def compute(answer, head, [next|[]], [op|ops]) do
    current = case op do
      :multiply -> head * next
      :add -> head + next
    end
    IO.puts("last input, more options #{answer} == #{head} #{op} #{next} -> #{current}")
    case current do
      c when c == answer -> [compute(answer, current, [], [op|ops])]
      _ -> [0|compute(answer, head, [next], ops)]
    end
  end

  # out of operations to try, doesn't matter what's left
  def compute(_, _, _, []) do
    IO.puts("No more operations")
    [0]
  end


  def compute(answer, head, [], _) do
    IO.puts("no more inputs, #{answer} == #{head}?")
    if answer == head do
      answer
    else
      0
    end
  end

  def compute(answer, head, [next|[]], [op|[]]) do
    current = case op do
      :multiply -> head * next
      :add -> head + next
    end
    IO.puts("calculating #{answer} == #{current}? #{head} #{op} #{next}")
    if answer == current do
      answer
    else
      0
    end
  end

  def compute(answer, head, [next|rest], [op|ops]) do
    current = case op do
      :multiply -> head * next
      :add -> head + next
    end
    IO.puts("computing.. #{answer} < #{head} #{op} #{next} -> #{current}")
    case current do
      c when c < answer -> [compute(answer, current, rest, [op|ops])]
      c when c == answer -> [0] # too soon
      _ -> [compute(answer, head, [next|rest], ops)]
    end
  end

  def leaf_calc(op, answer, left, right) do
    value = case op do
      :multiply -> left * right
      :add -> left + right
    end
    IO.puts("leaf calulation #{left} #{op} #{right} == #{answer}?")
    value == answer
  end


  def continue(answer, acc, [right|[]], ops) do
    ops |> Enum.map(& leaf_calc(&1, answer, acc, right)) |> Enum.any?
  end

  def continue(answer, acc, [right|rest], ops) do
    [continue(answer, acc, right, ops)  continue(answer, acc, rest, ops)]
  end



  @doc """
  ## Examples
      iex> Day7.compute(190, [10,19])
      190
      iex> Day7.compute(190, [190])
      190
      iex> Day7.compute(10, [5,5])
      10
      iex> Day7.compute(11, [5,2,1])
      11
      iex> Day7.compute(12, [5,2,1])
      0
      iex> Day7.compute(6, [5,2,1])
      0
      iex> Day7.compute(292, [11,6,16,20])
      292
  """
  def compute(answer, [head|rest]) do
    IO.puts("---trying to get #{answer}---")
    compute(answer, head, rest, [:multiply, :add])
  end

  def part1(lines) do
    lines
    |> Enum.map(& parse(&1))
    |> Enum.map(fn d -> compute(d.answer, d.input) end)
    |> tap(& IO.inspect(&1))
    |> Enum.sum
  end

  def main(_args) do
    {:ok, content} = File.read("input.txt")
    content
      |> String.split("\n")
      |> Enum.filter(fn l -> l != "" end)
      |> tap(& &1 |> part1 |> IO.puts)
      #|> part2 |> IO.puts
  end
end
