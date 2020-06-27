defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    1..number
    |> Enum.to_list
    |> Enum.filter(&(rem(number, &1) == 0))
    |> Enum.filter(&(&1 in [3, 5, 7]))
    |> Enum.map(&replace/1)
    |> to_return(number)
  end

  defp to_return([], number), do: "#{number}"
  defp to_return(result, _), do: Enum.join(result)

  defp replace(3), do: "Pling"
  defp replace(5), do: "Plang"
  defp replace(7), do: "Plong"
  defp replace(_), do: ""
end