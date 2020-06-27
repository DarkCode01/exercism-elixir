defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.codepoints
    |> do_encode(1, "")
  end

  defp do_encode([],  _, output) do
    output
  end
  defp do_encode([current],  acc, output) do
    "#{output}#{add_sequence(acc)}#{current}"
  end
  defp do_encode([firts, second | letters], acc, output) do
    case firts == second do
      true -> do_encode([second] ++ letters, acc + 1, output)
      false -> do_encode([second] ++ letters, 1, "#{output}#{add_sequence(acc)}#{firts}")
    end
  end

  defp add_sequence(1), do: ""
  defp add_sequence(sequence), do: "#{sequence}"

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.codepoints
    |> do_decode("0", "")
  end

  defp do_decode([],  _, output) do
    output
  end
  defp do_decode([current | tail], acc, output) do
    case String.match?(current, ~r/^[0-9]$/) do
      true -> do_decode(tail, acc <> current, output)
      false -> do_decode(tail, "0", "#{output}#{String.pad_leading(current, String.to_integer(acc), current)}")
    end
  end
end