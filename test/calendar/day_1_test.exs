defmodule AdventOfCode.Calendar.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Calendar.Day1

  test "fuel_required/1 calculates the fuel required for the given module mass" do
    assert Day1.fuel_required(12) == 2
    assert Day1.fuel_required(14) == 2
    assert Day1.fuel_required(1_969) == 654
    assert Day1.fuel_required(100_756) == 33_583
  end

  test "total_fuel_required/1 takes list of module masses and returns total fuel requirement" do
    assert Day1.total_fuel_required([12, 14, 1_969, 100_756]) == 34241.0
  end

  test "actual_fuel_required/1 calculates the fuel required for the given module mass and fuel mass" do
    assert Day1.actual_fuel_required(12) == 2
    assert Day1.actual_fuel_required(1_969) == 966
    assert Day1.actual_fuel_required(100_756) == 50346
  end

  test "total_actual_fuel_required/1 takes a list of module masses and returns fuel requirement for module mass and fuel mass" do
    assert Day1.actual_total_fuel_required([12, 1_969, 100_756]) == 51314.0
  end
end
