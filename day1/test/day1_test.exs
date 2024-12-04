defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "parse gets two ints" do
    assert Day1.parse("3   4") == [3,4]
  end
end
