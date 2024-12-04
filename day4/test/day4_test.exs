defmodule Day4Test do
  use ExUnit.Case
  doctest Day4


  test "returns 0 when leaf" do
    # TODO this should be a list
    assert Day4.search(%Tree{value: "a"}, ["z"], :down) == 0
  end

  test "returns 0s when 2 deep no match" do
    assert Day4.search(%Tree{value: "a",
      right: %Tree{value: "b"},
      down: %Tree{value: "c"},
      corner: %Tree{value: "d"}
    }, ["z"], :down) == 0
  end
  test "returns 0s when 2 deep first match" do
    assert Day4.search(%Tree{value: "a",
      right: %Tree{value: "b"},
      down: %Tree{value: "c"},
      corner: %Tree{value: "d"}
    }, ["a", "z"], :down) == 0
  end
  test "returns 1s when 2 deep all match" do
    assert Day4.search(%Tree{value: "a",
      right: %Tree{value: "b"},
      down: %Tree{value: "c"},
      corner: %Tree{value: "d"}
    }, ["a", "d"], :corner) == 1
  end

  test "returns 1s when 3 deep all match" do
    assert Day4.search(%Tree{value: "a",
      right: %Tree{value: "b",
        right: %Tree{value: "c"}
      },
      down: %Tree{value: "c"},
      corner: %Tree{value: "d"}
    }, ["a", "b", "c"], :right) == 1
  end

  test "returns 1 when 3 deep all multiple match but order matters" do
    assert Day4.search(%Tree{value: "a",
      right: %Tree{value: "b",
        right: %Tree{value: "c"}
      },
      down: %Tree{value: "b",
        right: %Tree{value: "c"}},
      corner: %Tree{value: "d"}
    }, ["a", "b", "c"], :right) == 1
  end
end
