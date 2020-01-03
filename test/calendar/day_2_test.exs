defmodule AdventOfCode.Calendar.Day2Test do
  use ExUnit.Case
  alias AdventOfCode.Calendar.Day2

  test "run_intcode/1 takes list of intcode program and returns result" do
    assert Day2.run_intcode([1, 0, 0, 0, 99]) == [2, 0, 0, 0, 99]
    assert Day2.run_intcode([2, 3, 0, 3, 99]) == [2, 3, 0, 6, 99]
    assert Day2.run_intcode([2, 4, 4, 5, 99, 0]) == [2, 4, 4, 5, 99, 9801]

    assert Day2.run_intcode([1, 1, 1, 4, 99, 5, 6, 0, 99]) == [
             30,
             1,
             1,
             4,
             2,
             5,
             6,
             0,
             99
           ]
  end
end
