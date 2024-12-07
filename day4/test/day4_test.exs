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

  test "parse makes linked list" do
    [a,b,c] = Day4.parse("ABC")
    assert a.right == b
    assert b.right == c
    assert c.right == nil
  end

  test "link attaches surroundings" do
    a = %Tree{value: 1}
    b = %Tree{value: 2}
    c = %Tree{value: 3}
    d = %Tree{value: 4}
    [a1,b1] = Day4.link([a,b], [c,d])
    assert a1.right == b1
    assert a1.corner == d
    assert a1.down == c
    assert b1.right == nil
    assert b1.corner == nil
    assert b1.down == d
  end
end
