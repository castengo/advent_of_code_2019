defmodule AdventOfCode do
  @moduledoc """
  Documentation for AdventOfCode.
  """
  alias AdventOfCode.Calendar.Day1

  def day1_result do
    data = Day1.get_data()

    %{
      part1: Day1.total_fuel_required(data),
      part2: Day1.actual_total_fuel_required(data)
    }
  end
end
