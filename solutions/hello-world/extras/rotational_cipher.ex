defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> apply_cipher(rem(shift, 26), "")
  end

  defp apply_cipher([], _, chypered), do: chypered
  defp apply_cipher([char | tail], shift, chypered) when char in 97..122 or char in 65..90 do
    apply_cipher(tail, shift, chypered <> <<char + shift :: utf8>>)
  end
  defp apply_cipher([char | tail], shift, chypered) do
    apply_cipher(tail, shift, chypered <> <<char :: utf8>>)
  end
end