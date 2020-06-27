defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when size >= 1 do
    s
    |> String.graphemes
    |> do_slice(size, [])
  end

  def slices(_s, _size) do
    do_slice([], 0, [])
  end
  
  def do_slice([], _size, output) do
    Enum.reverse(output)
  end

  def do_slice([ current | tail], size, output) when length([current | tail]) >= size do
    sliced = 
      tail
      |> Enum.slice(0, size - 1)
      |> Enum.join

    do_slice(tail, size, List.flatten([current <> sliced | output]))
  end

  def do_slice([_current | _tail], size, output) do
    do_slice([], size, output)
  end
end