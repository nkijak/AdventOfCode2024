defmodule Day12 do
  def search(map, el, x, y, h, w, dir)
  def search(_, _, x, y, h, w, _) when x >= w or x < 0 or y >= h or y < 0 do
    #IO.puts("Out of bounds")
    MapSet.new
  end

  def search(map, el, x, y, h, w, dir) do
    row = Enum.at(map, y)

    value = Enum.at(row, x)
    #IO.puts("looking for #{el} at #{x},#{y},  got #{value}")
    if el == value do
      map = List.replace_at(map, y, List.replace_at(row, x, nil))
      #IO.puts("found #{el} at #{x}, #{y}")

      [
        search(map, el, x+1, y, h, w, :right), # right
        search(map, el, x, y+1, h, w, :down), # down
        search(map, el, x-1, y, h, w, :left), # left
        search(map, el, x, y-1, h, w, :up)  # up
      ]
      |> Enum.reduce(MapSet.new([{x,y}]), fn el, acc ->
        MapSet.union(el, acc)
      end)
    else
      #IO.puts("miss at #{x}, #{y}")
      MapSet.new
    end
  end

  def area(point_set) do
    MapSet.size(point_set)
  end

  @doc """
      iex> Day12.fences(MapSet.new([{0,0}]), 0,0)
      4
  """
  def fences(point_set, x, y) do
    [
      MapSet.member?(point_set, {x+1, y}), #right
      MapSet.member?(point_set, {x, y+1}), #down
      MapSet.member?(point_set, {x-1, y}), #left
      MapSet.member?(point_set, {x, y-1}), #up
    ]
    |> Enum.map(& if &1, do: 0, else: 1)
    |> tap(& IO.puts("#{x},#{y}, #{inspect(&1)}"))
    |> Enum.sum
    |> tap(& IO.puts("#{x},#{y} = #{&1}"))
  end

  def perimeter(point_set, visited, x, y) do
    IO.inspect(visited)
    cond do
      MapSet.member?(visited, {x, y}) ->
        IO.puts("#{x}, #{y} visited")
        0
      MapSet.member?(point_set, {x, y}) ->
        init = {0,MapSet.put(visited, {x, y})}
        {sum, _} = [
          {x+1, y},
          {x, y+1},
          {x-1, y},
          {x, y-1},
        ]
        |> Enum.reduce(init, fn el, acc ->
          {ex,ey} = el
          {val, vis} = acc
          p = perimeter(point_set, vis, ex, ey)
          v = MapSet.put(vis, el)
          {val+p, v}
        end)

        sum + fences(point_set, x, y)
      true ->
        IO.puts("#{x}, #{y} not a member")
        0
    end
  end
end
