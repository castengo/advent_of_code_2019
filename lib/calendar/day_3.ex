defmodule AdventOfCode.Calendar.Day3 do
  @moduledoc """
  For instructions, visit: https://adventofcode.com/2019/day/3

  Manhattan distance. Definition: The distance between two points measured along axes at right angles.
  In a plane with p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|. Lm distance.
  """

  @typedoc "|x1 - x2| + |y1 - y2|"
  @type manhattan_distance :: non_neg_integer
  @typedoc "Total of grid number squares from one location to another"
  @type steps :: non_neg_integer
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
    {_, wire1_traveled} = Enum.reduce(wire1, {{0, 0, 0}, []}, &travel_wire/2)
    {_, wire2_traveled} = Enum.reduce(wire2, {{0, 0, 0}, []}, &travel_wire/2)

    # get rid of self intersections
    all_traveled_nodes =
      Enum.uniq_by(wire1_traveled, &uniq_xy/1) ++
        Enum.uniq_by(wire2_traveled, &uniq_xy/1)

    # find duplicates to find intersection
    (all_traveled_nodes -- Enum.uniq_by(all_traveled_nodes, &uniq_xy/1))
    |> Enum.map(fn {x, y, _} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  @doc """
  Finds the intersection where the sum of both wires' steps is lowest and returns the number of steps.
  """
  @spec find_steps(wire_instructions, wire_instructions) :: steps
  def find_steps(wire1, wire2) do
    {_, wire1_traveled} = Enum.reduce(wire1, {{0, 0, 0}, []}, &travel_wire/2)
    {_, wire2_traveled} = Enum.reduce(wire2, {{0, 0, 0}, []}, &travel_wire/2)

    # sort by lowest number of steps before uniq so first intersection is chosen
    sort_uniq = fn items ->
      items
      |> Enum.sort_by(fn {_x, _y, s} -> s end, &<=/2)
      |> Enum.uniq_by(&uniq_xy/1)
    end

    # I first tried this with a for loop and it was horrendously slow, leason learned
    # (I'm sure there are other ways to make this more efficient...)
    (sort_uniq.(wire1_traveled) ++ sort_uniq.(wire2_traveled))
    |> Enum.sort()
    |> find_intersection_steps([])
    |> Enum.min()
  end

  defp find_intersection_steps([_one], acc), do: acc

  defp find_intersection_steps(
         [{x, y, s}, {next_x, next_y, next_s} = next | rest],
         acc
       ) do
    case x === next_x and y === next_y do
      true -> find_intersection_steps(rest, [s + next_s | acc])
      false -> find_intersection_steps([next | rest], acc)
    end
  end

  defp uniq_xy({x, y, _}), do: {x, y}

  defp travel_wire("U" <> distance, {{x, y, s}, visited_nodes}),
    do: travel({x, y, s}, distance, visited_nodes, &move_up/2)

  defp travel_wire("D" <> distance, {{x, y, s}, visited_nodes}),
    do: travel({x, y, s}, distance, visited_nodes, &move_down/2)

  defp travel_wire("R" <> distance, {{x, y, s}, visited_nodes}),
    do: travel({x, y, s}, distance, visited_nodes, &move_right/2)

  defp travel_wire("L" <> distance, {{x, y, s}, visited_nodes}),
    do: travel({x, y, s}, distance, visited_nodes, &move_left/2)

  defp travel({x, y, s}, distance, nodes, move) do
    [{x_last, y_last, s_last} | _] =
      visited_nodes =
      Enum.reduce(
        1..String.to_integer(distance),
        nodes,
        &[move.({x, y, s + &1}, &1) | &2]
      )

    {{x_last, y_last, s_last}, visited_nodes}
  end

  defp move_up({x, y, s}, dist), do: {x, y + dist, s}
  defp move_down({x, y, s}, dist), do: {x, y - dist, s}
  defp move_right({x, y, s}, dist), do: {x + dist, y, s}
  defp move_left({x, y, s}, dist), do: {x - dist, y, s}
end
