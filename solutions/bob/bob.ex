defmodule Bob do
  def hey(input) do
    parser_input(input)
    |> do_hey
  end

  def do_hey(input) do
    cond do
      validate_upcase(input) and String.ends_with?(input, "?") -> "Calm down, I know what I'm doing!"
      validate_upcase(input) -> "Whoa, chill out!"
      String.ends_with?(String.trim(input), "?") -> "Sure."
      String.match?(input, ~r/[a-zA-Z0-9]+/) -> "Whatever."
      true -> "Fine. Be that way!"
    end
  end

  defp parser_input(input), do: String.trim(input)

  defp validate_upcase(input) do
    String.match?(input, ~r/[a-zA-Z|\p{L}]+/) and String.upcase(input) == input
  end
end