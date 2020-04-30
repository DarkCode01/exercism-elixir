defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> String.to_charlist
    |> Enum.chunk_every(3)
    |> of_rna("")
    |> handler_error("RNA")
  end
  def of_rna([], ouput), do: ouput
  def of_rna([current | tail], ouput) do
    code = current
           |> List.to_string
           |> get_protein

    case code do
      "ERROR" -> "ERROR"
      "STOP" -> of_rna([], ouput)
      protein -> of_rna(tail, "#{ouput} #{protein}")
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    codon
    |> get_protein
    |> handler_error("codon")
  end

  defp get_protein(code), do: Map.get(@proteins, code, "ERROR")

  defp handler_error("ERROR", type), do: {:error, "Invalid #{type}"}
  defp handler_error(data, _type), do: {:ok, data}
end