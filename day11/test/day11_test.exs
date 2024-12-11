defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  test "example blink once" do
    assert Day11.rules([125,17]) == [253000,1,7]
  end
  test "example blink 2" do
    assert Day11.rules([253000,1,7]) == [253,0,2024,14168]
  end

  test "After 3 blinks" do
    assert Day11.rules([253,0,2024,14168]) == [512072,1,20,24,28676032]
  end

  test "After 4 blinks" do
    assert Day11.rules([512072,1,20,24,28676032]) == [512,72,2024,2,0,2,4,2867,6032]
  end

  test "After 5 blinks" do
    assert Day11.rules([512,72,2024,2,0,2,4,2867,6032]) == [1036288,7,2,20,24,4048,1,4048,8096,28,67,60,32]
  end

  test "After 6 blinks" do
    assert Day11.rules([1036288,7,2,20,24,4048,1,4048,8096,28,67,60,32]) == [2097446912,14168,4048,2,0,2,4,40,48,2024,40,48,80,96,2,8,6,7,6,0,3,2]
  end


end
