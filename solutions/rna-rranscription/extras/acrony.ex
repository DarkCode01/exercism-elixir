defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  # @spec abbreviate(String.t()) :: String.t()
  # def abbreviate(string) do
  #   Regex.scan(~r/[A-Z]/, string)
  #   |> List.flatten
  #   |> Enum.join
  # end
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(" ")
    |> do_abbreviate("")
  end

  defp do_abbreviate([], output) do
    output
  end

  defp do_abbreviate([word | tail], output) do
    cond do
      is_upcase(word) -> do_abbreviate(tail, output <> get_letter(word))
      String.match?(word, ~r/[[:upper:]]+/u) ->
        letter = 
          Regex.scan(~r/[[:upper:]]/, word)
          |> List.flatten
          |> Enum.join

        do_abbreviate(tail, output <> letter)
      true -> do_abbreviate(tail, output <> get_letter(word))
    end
  end

  defp is_upcase(string), do: String.upcase(string) == string

  defp get_letter(string) do
    try do
      Regex.scan(~r/[[:alpha:]]/, string)
        |> List.flatten
        |> hd
        |> String.upcase
    rescue
      _ in ArgumentError -> ""
    end
  end
end