defmodule CollatzConjecture do
  require Integer

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when input <= 0 or is_binary(input), do: raise FunctionClauseError
  def calc(input), do: calc(input, 0)
  def calc(1, steps), do: steps
  def calc(input, steps) do 
    case Integer.is_even(input) do
      true -> calc(div(input, 2), steps + 1)
      _ -> calc((3 * input) + 1, steps + 1)
    end
  end
end