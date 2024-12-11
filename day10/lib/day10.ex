defmodule Day10 do
  def render(map) do
    map
    |> Enum.map(fn row ->
      row
      |> Enum.map(& if &1 == nil, do: " ", else: &1)
      |> Enum.join
    end )
    |> Enum.join("\n")
  end

  @spec trail(list(), nonempty_maybe_improper_list(), any(), any()) :: number()
  def trail(map, steps, x, y, dir \\ :any)
  def trail(map, [curr|[]], x, y, dir) do
    #IO.puts("last step")
    #IO.inspect(dir)
    #IO.puts(render(map))
    width = length(Enum.at(map, 0))
    height = length(map)
    if x == width or x < 0 or y == height or y < 0 do
      #IO.puts("#{x} or #{y} OoB")
      MapSet.new
    else
      row = Enum.at(map, y)
      if curr == Enum.at(row, x) do
        #IO.puts("Found last step at #{x}, #{y}")
        map = List.replace_at(map, y, List.replace_at(row, x, "X"))
        #IO.puts(render(map))
        #IO.puts("___")
        MapSet.new([{x,y}])
      else
        #IO.puts("Failed last at #{x}, #{y}")
        map = List.replace_at(map, y, List.replace_at(row, x, nil))
        #IO.puts(render(map))
        MapSet.new
      end
    end
  end

  def trail(map, [curr|steps], x, y, dir) do
    #IO.inspect(dir)
    #IO.puts(render(map))
    #IO.puts("Looking at #{x}, #{y} for #{curr}")
    width = length(Enum.at(map, 0))
    height = length(map)
    if x == width or x < 0 or y == height or y < 0 do
      #IO.puts("Out of bounds")
      MapSet.new
    else
      row = Enum.at(map, y)
      if curr == Enum.at(row, x) do
        map = List.replace_at(map, y, List.replace_at(row, x, "X"))
        #IO.puts("found #{curr} at #{x}, #{y}")
        [
          trail(map, steps, x+1, y, [dir, :right]), # right
          trail(map, steps, x, y+1, [dir, :down]), # down
          trail(map, steps, x-1, y, [dir, :left]), # left
          trail(map, steps, x, y-1, [dir, :up])  # up
        ]
        |> tap(fn el ->
          #IO.inspect(dir)
          #IO.inspect(el)
        end)
        |> Enum.reduce(fn el, acc ->
          MapSet.union(el, acc)
        end)
      else
        #IO.puts("Failed at #{x}, #{y} looking for #{curr}")
        map = List.replace_at(map, y, List.replace_at(row, x, nil))
        #IO.puts(render(map))
        MapSet.new
      end
    end
  end

  def parse(line) do
    line |> String.codepoints |> Enum.map(fn c ->
      case Integer.parse(c) do
        {i, _}  -> i
        :error ->
          exit("Could not parse >#{c}<")
      end
    end)
  end

  def part1(map) do
    rows = length(map)
    cols =  length(Enum.at(map, 0))
    0..(rows - 1) |>
      Enum.map(fn row ->
        0..(cols - 1)
        |> Enum.map(fn col ->
          trails = trail(map, [0,1,2,3,4,5,6,7,8,9], row, col) |> MapSet.size
          if trails > 0 do
            IO.puts("start at #{row}, #{col} -> #{trails}")
          end
          trails
        end)
        |> Enum.sum
      end)
      |> Enum.sum
  end

  def main(_args) do
    {:ok, content} = File.read("input.txt")
    content
      |> String.split("\n")
      |> Enum.filter(fn l -> l != "" end)
      |> Enum.map(& parse(&1))
      |> tap(& &1 |> part1 |> IO.puts)
      #|> part2 |> IO.puts
  end
end
