defmodule Day13Test do
  use ExUnit.Case
  doctest Day13

  test "parse" do
    lines = """
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176
""" |> String.split("\n")
    assert Day13.parse(lines) == [
      %{:a => {94,34}, :b => {22,67}, :prize => {8400,5400}},
      %{:a => {26,66}, :b => {67,21}, :prize => {12748,12176}},
    ]
  end

  test "solve" do
    assert Day13.solve(%{:a => {94,34}, :b => {22,67}, :prize => {8400,5400}}) == {1,2}
  end
end
