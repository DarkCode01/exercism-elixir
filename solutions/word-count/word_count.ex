defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split(~r/[^[:alnum:]-]/u, trim: true)
    |> count_p(%{})
  end

  defp count_p([firts | tail], words) do
    count_p(tail, Map.put(words, firts, Map.get(words, firts, 0) + 1))
  end
  defp count_p(_, words) do
    words
  end
end