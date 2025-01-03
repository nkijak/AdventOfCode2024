
defmodule Day11Part2Test do
  use ExUnit.Case

  def counts(values) do
    values |> Enum.reduce(%{}, fn el, acc ->
      Map.update(acc, el, 1, &(&1 + 1))
    end)
    |> Map.values
    |> Enum.sum
  end

  test "example blink once" do
    assert Day11.Part2.part("125 17", 1) == 3
  end
  test "example blink 2" do
    assert Day11.Part2.part("125 17", 2) == 4
  end

  test "After 3 blinks" do
    assert Day11.Part2.part("125 17", 3)
      == 5
  end

  test "After 4 blinks" do
    assert Day11.Part2.part("125 17", 4)
      == counts([512,72,2024,2,0,2,4,2867,6032])
  end

  test "After 5 blinks" do
    assert Day11.Part2.part("125 17", 5)
      == counts([1036288,7,2,20,24,4048,1,4048,8096,28,67,60,32])
  end

  test "After 6 blinks" do
    assert Day11.Part2.part("125 17", 6)
      == counts([2097446912,14168,4048,2,0,2,4,40,48,2024,40,48,80,96,2,8,6,7,6,0,3,2])

    assert Day11.Part2.part("125 17", 6) == 22
  end

  test "smaller After 7 blinks" do
    # 40           48              40        48
    # 4      0     4       8       4      0  4       8
    # 4*2024 2024  4*2024  8*2024  4*2048 1  4*2024  8*2024
    assert Day11.Part2.part("40 48 40 48", 2) == counts([4*2024,2024,4*2024,8*2024,4*2024,1,4*2024,8*2024])
  end

  test "After 7 blinks" do
    assert Day11.Part2.part("125 17", 7)
      == counts([20974, 46912,14168*2024,40, 48,4048,1,4048,4*2048,4,0,4,8,20,24,4,0,4,8,8,0,9,6,4048,8*2024,6*2024,7*2024,6*2024,1,3*2024,4048])
  end

  test "After 25 blinks" do
    assert Day11.Part2.part("125 17", 25) == 55312
  end

  test "part1" do
    assert Day11.Part2.part("890 0 1 935698 68001 3441397 7221 27", 25) == 194782
  end
  test "part2" do
    assert Day11.Part2.part("890 0 1 935698 68001 3441397 7221 27", 75) == 233007586663131
  end

end
