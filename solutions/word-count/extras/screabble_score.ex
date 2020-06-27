defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @one_point ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]
  @two_point ["D", "G"]
  @three_point ["B", "C", "M", "P"]
  @four_point ["F", "H", "V", "W", "Y"]
  @five_point ["K"]
  @eight_point ["J", "X"]
  @ten_point ["Q", "Z"]

  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.split("")
    |> Enum.reduce(0, &(do_score(&1) + &2))
  end

  defp do_score(letter) do
    cond do
      letter in @one_point -> 1
      letter in @two_point -> 2
      letter in @three_point -> 3
      letter in @four_point -> 4
      letter in @five_point -> 5
      letter in @eight_point -> 8
      letter in @ten_point -> 10
      true -> 0
    end
  end
end