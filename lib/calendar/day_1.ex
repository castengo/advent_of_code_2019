defmodule AdventOfCode.Calendar.Day1 do
  @moduledoc """
  For instructions, visit: https://adventofcode.com/2019/day/1
  """

  @type fuel_mass :: float
  @type module_mass :: non_neg_integer

  @doc "Gets list of module masses from file"
  @spec get_data(Path.t()) :: [module_mass]
  def get_data(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  @doc "Fuel required to launch all modules"
  @spec total_fuel_required([module_mass]) :: fuel_mass
  def total_fuel_required(masses) do
    masses
    |> Enum.map(&fuel_required/1)
    |> Enum.reduce(0, &+/2)
  end

  @doc "Fuel required to launch given mass"
  @spec fuel_required(module_mass | fuel_mass) :: fuel_mass
  def fuel_required(mass) do
    mass
    |> divide_by(3)
    |> Float.floor()
    |> substract(2)
    |> cap_at_zero()
  end

  @spec divide_by(number, integer) :: float
  defp divide_by(dividend, divisor), do: dividend / divisor

  @spec substract(float, integer) :: float
  defp substract(operand, substractor), do: operand - substractor

  @spec cap_at_zero(float) :: float
  defp cap_at_zero(total) when total < 0, do: 0
  defp cap_at_zero(total), do: total

  @doc "Fuel required to launch modules taking into account fuel mass"
  @spec actual_total_fuel_required([module_mass]) :: fuel_mass
  def actual_total_fuel_required(masses) do
    masses
    |> Enum.map(&actual_fuel_required/1)
    |> Enum.reduce(0, &+/2)
  end

  @doc "Fuel required to launch given module taking into account fuel mass"
  @spec actual_fuel_required(module_mass) :: fuel_mass
  def actual_fuel_required(module_mass) do
    module_mass
    |> fuel_required()
    |> add_fuel_mass_fuel(0)
  end

  defp add_fuel_mass_fuel(fuel_mass, total_fuel_mass) when fuel_mass > 0 do
    fuel_mass
    |> fuel_required()
    |> add_fuel_mass_fuel(total_fuel_mass + fuel_mass)
  end

  defp add_fuel_mass_fuel(_fuel_mass, total_fuel_mass), do: total_fuel_mass
end
