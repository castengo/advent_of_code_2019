defmodule AdventOfCode.Calendar.Day1 do
  @moduledoc """
  For instructions, visit: https://adventofcode.com/2019/day/1
  """

  @typedoc "Fuel required to launch a module"
  @type fuel_requirement :: float
  @typedoc "Mass of module"
  @type module_mass :: integer

  @doc "Gets list of module masses from file"
  @spec get_data :: [module_mass]
  def get_data do
    "lib/input/day_1.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  @doc "Fuel required to launch list of module masses"
  @spec total_fuel_required([module_mass]) :: fuel_requirement
  def total_fuel_required(module_masses) do
    module_masses
    |> Enum.map(&fuel_required/1)
    |> IO.inspect()
    |> Enum.reduce(0, &+/2)
  end

  @doc "Fuel required to launch given module mass"
  @spec fuel_required(module_mass) :: fuel_requirement
  def fuel_required(module_mass) do
    module_mass
    |> divide_by(3)
    |> Float.floor()
    |> substract(2)
  end

  @spec divide_by(integer, integer) :: float
  defp divide_by(dividend, divisor), do: dividend / divisor

  @spec substract(number, number) :: float
  defp substract(operand, substractor), do: operand - substractor
end
