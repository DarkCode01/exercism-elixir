defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep(list, fun, [])
  end
  def keep([], _, result), do: result
  def keep([current | tail], fun, result) do
    case fun.(current) do
      true -> keep(tail, fun, result ++ [current])
      false -> keep(tail, fun, result)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    discard(list, fun, [])
  end
  def discard([], _, result), do: result
  def discard([current | tail], fun, result) do
    case fun.(current) do
      false -> keep(tail, fun, result ++ [current])
      true -> keep(tail, fun, result)
    end
  end
end