defmodule AdventOfCode.Calendar.Day3Test do
  use ExUnit.Case
  alias AdventOfCode.Calendar.Day3

  test "find the manhattan distance from central port to closest intersection" do
    wire1 = ["R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"]
    # wire1 = ["U3", "R3", "D3", "L3"]
    wire2 = ["U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"]
    assert Day3.find_distance(wire1, wire2) == 159
  end
end
