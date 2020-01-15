defmodule AdventOfCode do
  @moduledoc """
  Documentation for AdventOfCode.
  """
  alias AdventOfCode.Calendar.{
    Day1,
    Day2,
    Day3
  }

  def day1_result do
    data = Day1.get_data("lib/input/day_1.txt")

    %{
      part1: Day1.total_fuel_required(data),
      part2: Day1.actual_total_fuel_required(data)
    }
  end

  def day2_result do
    data = Day2.get_data("lib/input/day_2.txt")

    part2 = fn output ->
      {noun, verb} = Day2.find(data, output)
      noun * 100 + verb
    end

    %{
      part1: data |> Day2.restore(12, 2) |> Day2.run_intcode() |> hd(),
      part2: part2.(19_690_720)
    }
  end

  @doc """
  Part1: What is the Manhattan distance from the central port to the closest intersection? A: 1674
  """
  def day3_result do
    [wire1, wire2] = Day3.get_data("lib/input/day_3.txt")

    %{
      part1: Day3.find_distance(wire1, wire2)
    }
  end
end
