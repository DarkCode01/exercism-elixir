defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels ["a", "e", "i", "o", "u"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> convert_to_list
    |> verify_phrase([])
    |> add_ay
  end

  defp convert_to_list(phrase) do
    String.split(phrase, "", trim: true)
  end

  defp add_ay(phrase) do
    phrase <> "ay"
  end

  defp join(phrase) do
    Enum.join(phrase)
  end

  defp verify_phrase([head | tail], foot) when head in @vowels do
    join([head] ++ tail ++ foot)
  end
  defp verify_phrase([head | tail], foot) do
    verify_phrase(tail, [head] ++ foot)
  end
  defp verify_phrase([], foot) do
    join(foot)
  end