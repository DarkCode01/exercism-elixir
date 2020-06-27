defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    accumulate(list, fun, [])
  end
  def accumulate([current | tail], fun, output) do
    accumulate(tail, fun, [fun.(current) | output])
  end
  def accumulate([], _fun, output) do
    Enum.reverse(output)
  end
end