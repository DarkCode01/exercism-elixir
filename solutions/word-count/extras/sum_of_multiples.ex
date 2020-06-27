defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.map(fn number -> get_multiples(number, limit) end)
    |> List.flatten
    |> Enum.uniq
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp get_multiples(number, limit) do
    1..limit
    |> Stream.map(& &1 * number)
    |> Stream.filter(& &1 < limit)
    |> Enum.to_list
  end
end