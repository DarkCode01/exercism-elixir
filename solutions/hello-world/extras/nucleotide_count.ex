defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide), do: count(strand, nucleotide, 0)
  def count([], _, total), do: total
  def count([head | tail], nucleotide, total) do
    case head == nucleotide do
      true -> count(tail, nucleotide, total + 1)
      false -> count(tail, nucleotide, total)
    end
  end
  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand), do: histogram(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  def histogram([], histogram_), do: histogram_
  def histogram([head | tail], histogram_) do
    histogram(tail, Map.merge(histogram_, %{head => Map.get(histogram_, head, 0) + 1}))
  end
end