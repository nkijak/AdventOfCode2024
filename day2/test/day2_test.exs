defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "greets the world" do
    assert Day2.hello() == :world
  end

  test "dampened_all denies specific index" do
    assert Day2.dampened_all?([1,2,1], true, 1, fn i -> i==1 end) == {true, 1}
  end

  test "dampened_all respects specific index and fails others, returning own failure index" do
    assert Day2.dampened_all?([1,2,1], true, 0, fn i -> i==1 end) == {false, 1}
  end

  test "dampened_all with normal pass" do
    assert Day2.dampened_all?([1,2,2,1], true, -1, fn i -> i < 3 end) == {true, -1}
  end

  @tag :wip
  test "dampened safe" do
    assert Day2.safe([1,2,2,1], true) == true
    assert Day2.safe([-1,-5,-1,-1], true) == false
    assert Day2.safe([2,1,4,1], true) == false
    assert Day2.safe([-2,1,-2,-1], true) == true
    assert Day2.safe([2,2,0,3], true) == true
    assert Day2.safe([-2,-3,-1,-2], true) == true
  end
end
