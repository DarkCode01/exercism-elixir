defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    rna = %{'G' => 'C', 'C' => 'G', 'T' => 'A', 'A' => 'U'}
    Enum.map(dna, fn(x) -> rna[to_charlist(<<x :: utf8>>)] end) |> Enum.join |> to_charlist
  end
end