defmodule AdventOfCode.Calendar.Day3 do
  @moduledoc """
  For instructions, visit: https://adventofcode.com/2019/day/3

  Manhattan distance. Definition: The distance between two points measured along axes at right angles.
  In a plane with p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|. Lm distance.
  """

  @typedoc "|x1 - x2| + |y1 - y2|"
  @type manhattan_distance :: non_neg_integer
  @typedoc "List of instructions in format (U|D|R|L)(integer)"
  @type wire_instructions :: [String.t()]

  @doc "Gets wires instructions from file"
  @spec get_data(Path.t()) :: [wire_instructions]
  def get_data(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",", trim: true))
  end

  @doc """
  Given two wire paths, finds the manhattan distance from central port to closest intersection.
  """
  @spec find_distance(wire_instructions, wire_instructions) ::
          manhattan_distance
  def find_distance(wire1, wire2) do
    {_, wire1_traveled} = Enum.reduce(wire1, {{0, 0}, []}, &travel_wire/2)
    {_, wire2_traveled} = Enum.reduce(wire2, {{0, 0}, []}, &travel_wire/2)
    # get rid of self intersections
    all_traveled_nodes = Enum.uniq(wire1_traveled) ++ Enum.uniq(wire2_traveled)
    # find duplicates to find intersection
    (all_traveled_nodes -- Enum.uniq(all_traveled_nodes))
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  defp travel_wire("U" <> distance, {{x, y}, visited_nodes}),
    do: travel({x, y}, distance, visited_nodes, &move_up/2)

  defp travel_wire("D" <> distance, {{x, y}, visited_nodes}),
    do: travel({x, y}, distance, visited_nodes, &move_down/2)

  defp travel_wire("R" <> distance, {{x, y}, visited_nodes}),
    do: travel({x, y}, distance, visited_nodes, &move_right/2)

  defp travel_wire("L" <> distance, {{x, y}, visited_nodes}),
    do: travel({x, y}, distance, visited_nodes, &move_left/2)

  defp travel({x, y}, distance, nodes, action) do
    [{x_last, y_last} | _] =
      visited_nodes =
      Enum.reduce(
        1..String.to_integer(distance),
        nodes,
        &[action.({x, y}, &1) | &2]
      )

    {{x_last, y_last}, visited_nodes}
  end

  defp move_up({x, y}, dist), do: {x, y + dist}
  defp move_down({x, y}, dist), do: {x, y - dist}
  defp move_right({x, y}, dist), do: {x + dist, y}
  defp move_left({x, y}, dist), do: {x - dist, y}
end
