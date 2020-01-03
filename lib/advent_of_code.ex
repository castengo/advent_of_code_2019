defmodule AdventOfCode do
  @moduledoc """
  Documentation for AdventOfCode.
  """
  alias AdventOfCode.Calendar.Day1

  def day1_result_part1 do
    Day1.get_data() |> Day1.total_fuel_required()
  end
end
