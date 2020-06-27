defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  defguard is_dir?(d) when d == :north or d == :east or d == :west or d == :south

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create() do
    create(:north, {0, 0})
  end
  def create(direction, {x, y}) when is_dir?(direction) and is_number(x) and is_number(y) do
    %{dir: direction, pos: {x, y}}
  end
  def create(direction, _) when is_dir?(direction) do
    {:error, "invalid position"}
  end
  def create(_, _) do
    {:error, "invalid direction"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.codepoints
    |> do_simulate(robot)
  end

  defp do_simulate([], robot) do
    robot
  end
  defp do_simulate(["A" | instructions], %{dir: d, pos: p}) do
    do_simulate(instructions, %{dir: d, pos: do_position(p, d)})
  end
  defp do_simulate(["L" | instructions], %{dir: d, pos: p}) do
    do_simulate(instructions, %{dir: do_direction(d, "L"), pos: p})
  end
  defp do_simulate(["R" | instructions], %{dir: d, pos: p}) do
    do_simulate(instructions, %{dir: do_direction(d, "R"), pos: p})
  end
  defp do_simulate(_, _) do
    {:error, "invalid instruction"}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.dir
  end

  defp do_direction(:north, "R"), do: :east
  defp do_direction(:north, "L"), do: :west
  defp do_direction(:east, "R"), do: :south
  defp do_direction(:east, "L"), do: :north
  defp do_direction(:south, "R"), do: :west
  defp do_direction(:south, "L"), do: :east
  defp do_direction(:west, "R"), do: :north
  defp do_direction(:west, "L"), do: :south

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.pos
  end

  defp do_position({x, y}, :north), do: {x, y + 1}
  defp do_position({x, y}, :east), do: {x + 1, y}
  defp do_position({x, y}, :west), do: {x - 1, y}
  defp do_position({x, y}, :south), do: {x, y - 1}
end