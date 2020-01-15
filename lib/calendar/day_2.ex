defmodule AdventOfCode.Calendar.Day2 do
  @moduledoc """
  For instructions, visit: https://adventofcode.com/2019/day/2
  """

  @typedoc "Intcode program"
  @type intcode_program :: [non_neg_integer]
  @typedoc "Instruction with opcode (1, 2 or 99) and parameters"
  @type instruction :: [non_neg_integer]
  @typedoc "Instruction pointer"
  @type pointer :: non_neg_integer
  @typedoc "First value of resulting intcode program"
  @type output :: non_neg_integer
  @typedoc "Value at address 1"
  @type noun :: non_neg_integer
  @typedoc "Value at address 2"
  @type verb :: non_neg_integer

  @doc "Gets Intcode program from file"
  @spec get_data(Path.t()) :: intcode_program
  def get_data(file_path) do
    file_path
    |> File.read!()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  @doc "Restores program by giving it initial noun and verb values"
  @spec restore(intcode_program, noun, verb) :: intcode_program
  # TODO: needs test
  def restore([num0, _num1, _num2 | rest], noun, verb),
    do: [num0, noun, verb | rest]

  @spec find(intcode_program, output) :: {noun, verb}
  # TODO: needs test
  def find(intcode_program, output) do
    combo_result = fn noun, verb ->
      intcode_program
      |> restore(noun, verb)
      |> run_intcode()
      |> hd()
    end

    result =
      for noun <- 0..99,
          verb <- 0..99,
          combo_result.(noun, verb) == output,
          do: {noun, verb}

    hd(result)
  end

  @doc "Runs Intcode program"
  @spec run_intcode(intcode_program) :: intcode_program
  def run_intcode(program), do: run_intcode(program, 0)

  @spec run_intcode(intcode_program, pointer) :: intcode_program | :error
  defp run_intcode(program, pointer) when pointer == length(program),
    do: program

  defp run_intcode(program, pointer) do
    line_range = pointer..(pointer + 3)

    case Enum.at(program, pointer) do
      99 ->
        program

      opcode when opcode in [1, 2] ->
        program
        |> Enum.slice(line_range)
        |> process_instruction(program)
        |> run_intcode(pointer + 4)

      _ ->
        :error
    end
  end

  @spec process_instruction(instruction, intcode_program) :: intcode_program
  defp process_instruction([1, pos1, pos2, pos3], program) do
    result = Enum.at(program, pos1) + Enum.at(program, pos2)
    List.replace_at(program, pos3, result)
  end

  defp process_instruction([2, pos1, pos2, pos3], program) do
    result = Enum.at(program, pos1) * Enum.at(program, pos2)
    List.replace_at(program, pos3, result)
  end
end
