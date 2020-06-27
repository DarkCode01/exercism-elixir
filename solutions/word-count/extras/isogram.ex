defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase
    |> String.to_charlist
    |> Enum.frequencies
    |> Map.to_list
    |> Enum.filter(fn {k, _} -> k in ?a..?z end)
    |> Enum.all?(fn {_, n} -> n == 1 end)
  end
end