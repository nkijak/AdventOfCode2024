defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  test "simple map, 1 trail head, 1 trail" do
    map = [[0,1,2], [5, 4, 3], [6,7,8], [1,1, 9]]
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 0,0) |> MapSet.size  == 1
  end

  test "simple map, 1 trail head, 3 trails, same point" do
    map = [[0,1,2], [5, 4, 3], [6, 7, 8], [7, 8, 9]]
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 0,0) |> MapSet.size  == 1
  end

  @tag :wip
  test "very simple map, 1 trail head, 2 trails" do
    map = [[0,1,2], [1, 4, 3], [2, 7, 8], [3, 8, 9]]
    assert Day10.trail(map, [0,1,2,3], 0,0) |> MapSet.size == 2
  end

  test "example" do
    map = [ [8,9,0,1,0,1,2,3],
            [7,8,1,2,1,8,7,4],
            [8,7,4,3,0,9,6,5],
            [9,6,5,4,9,8,7,4],
            [4,5,6,7,8,9,0,3],
            [3,2,0,1,9,0,1,2],
            [0,1,3,2,9,8,0,1],
            [1,0,4,5,6,7,3,2]]
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 2,0) |> MapSet.size == 5
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 4,0) |> MapSet.size == 6
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 4,2) |> MapSet.size == 5
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 6,4) |> MapSet.size == 3
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 2,5) |> MapSet.size == 1
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 5,5) |> MapSet.size == 3
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 0,6) |> MapSet.size == 5
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 6,6) |> MapSet.size == 3
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 1,7) |> MapSet.size == 5
  end

  test "example part1" do
    map = [ [8,9,0,1,0,1,2,3],
            [7,8,1,2,1,8,7,4],
            [8,7,4,3,0,9,6,5],
            [9,6,5,4,9,8,7,4],
            [4,5,6,7,8,9,0,3],
            [3,2,0,1,9,0,1,2],
            [0,1,3,2,9,8,0,1],
            [1,0,4,5,6,7,3,2]]
    assert Day10.part1(map) == 36
  end

  test "example part2" do
    map = [ [8,9,0,1,0,1,2,3],
            [7,8,1,2,1,8,7,4],
            [8,7,4,3,0,9,6,5],
            [9,6,5,4,9,8,7,4],
            [4,5,6,7,8,9,0,3],
            [3,2,0,1,9,0,1,2],
            [0,1,3,2,9,8,0,1],
            [1,0,4,5,6,7,3,2]]
    assert Day10.part2(map) == 81
  end

  test "smaller example" do
    map = [
      [1,0,".",".",9,".","."],
      [2,".",".",".",8,".","."],
      [3,".",".",".",7,".","."],
      [4,5,6,7,6,5,4],
      [".",".",".",8,".",".",3],
      [".",".",".",9,".",".",2],
      [".",".",".",".",".",0,1]]
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 1,0)|> MapSet.size == 1
    assert Day10.trail(map, [0,1,2,3,4,5,6,7,8,9], 5,6)|> MapSet.size == 2
  end
end
