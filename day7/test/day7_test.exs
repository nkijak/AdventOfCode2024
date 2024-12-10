defmodule Day7Test do
  use ExUnit.Case
  #doctest Day7

  test "compute bottom" do
    assert Day7.continue(292, 272, [20], [:multiply, :add]) == true
  end

  test "compute 1 up" do
    assert Day7.continue(292, 17, [16, 20], [:multiply, :add]) == true
  end

  test "compute 2 up" do
    assert Day7.continue(292, 11, [6, 16, 20], [:multiply, :add]) == true
  end


  @tag :wip
  test "part1" do
   assert Day7.part1([
            "190: 10 19",
            "3267: 81 40 27",
            "83: 17 5",
            "156: 15 6",
            "7290: 6 8 6 15",
            "161011: 16 10 13",
            "192: 17 8 14",
            "21037: 9 7 18 13",
            "292: 11 6 16 20"
          ]) == 3749
  end
end
