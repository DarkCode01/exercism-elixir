defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: do_count(list, 0)

  defp do_count([], output), do: output
  defp do_count([_ | tail], output), do: do_count(tail, output + 1)

  @spec reverse(list) :: list
  def reverse(l), do: do_reverse(l, [])

  defp do_reverse([], output), do: output
  defp do_reverse([current | tail], output), do: do_reverse(tail, [ current | output])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f)

  defp do_map([], _), do: []
  defp do_map([current | tail], f), do: [f.(current) | do_map(tail, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f)

  defp do_filter([], _), do: []
  defp do_filter([current | tail], f) do
    case f.(current) do
      true -> [current | do_filter(tail, f)]
      _ -> do_filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc \\ 0, f), do: do_reduce(l, acc, f)

  defp do_reduce([], acc, _), do: acc
  defp do_reduce([current | tail], acc, f), do: do_reduce(tail, f.(current, acc), f)

  @spec append(list, list) :: list
  def append(a, b), do: do_append(reverse(a), b)

  defp do_append([], []), do: []
  defp do_append(a, []), do: reverse(a)
  defp do_append([], b), do: b
  defp do_append([current | a], b), do: do_append(a, [current | b])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: do_concat(ll, [])

  defp do_concat([], output), do: reverse(output)
  defp do_concat([current | ll], []), do: do_concat(ll, reverse(current))
  defp do_concat([current | ll], output), do: do_concat(ll, append(reverse(current), output))
end