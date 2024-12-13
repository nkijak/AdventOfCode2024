defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  test "small example" do
    map = [
      [A,A,A,A],
      [B,B,C,D],
      [B,B,C,C],
      [E,E,E,C]]
    assert Day12.search(map, B, 0,1, 3,4,:start) == MapSet.new([
      {0,1},
      {1,1},
      {1,2},
      {0,2}
    ])
  end

  test "outer, mixed" do
    map =[
      ["O","O","O","O","O"],
      ["O","X","O","X","O"],
      ["O","O","O","O","O"],
      ["O","X","O","X","O"],
      ["O","O","O","O","O"]
    ]
    assert Day12.search(map, "O", 0,0, 5,5, :start) == MapSet.new([
      {0,0}, {0,1}, {0,2}, {0,3},{0,4},
      {1,0},  {1,2}, {1,4},
      {2,0}, {2,1}, {2,2}, {2,3},{2,4},
      {3,0}, {3,2},{3,4},
      {4,0}, {4,1}, {4,2}, {4,3},{4,4}
    ])
  end

  test "permeter" do
    set = MapSet.new([
      {0,1}, {1,1},
      {0,2}, {1,2}
    ])

    assert Day12.perimeter(set, MapSet.new, 0,1) == 8
  end

  @tag :fence
  test "fences" do
    set = MapSet.new([
      {0,0}, {0,1}, {0,2}, {0,3},{0,4},
      {1,0},  {1,2}, {1,4},
      {2,0}, {2,1}, {2,2}, {2,3},{2,4},
      {3,0}, {3,2},{3,4},
      {4,0}, {4,1}, {4,2}, {4,3},{4,4}
    ])

    assert Day12.fences(set, 0,0) == 2
    assert Day12.fences(set, 0,1) == 2
    assert Day12.fences(set, 2,2) == 0
    assert Day12.fences(set, 1,1) == 0
    assert Day12.fences(set, 2,4) == 1
  end

  @tag :fail
  test "perimeter complex" do

    set = MapSet.new([
      {0,0}, {0,1}, {0,2}, {0,3},{0,4},
      {1,0},  {1,2}, {1,4},
      {2,0}, {2,1}, {2,2}, {2,3},{2,4},
      {3,0}, {3,2},{3,4},
      {4,0}, {4,1}, {4,2}, {4,3},{4,4}
    ])
    [{x,y}] = Enum.take(set, 1)
    IO.puts("Starting with #{x}, #{y}")
    assert Day12.perimeter(set, MapSet.new,  x, y) == 36
  end
end
