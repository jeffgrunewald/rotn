defmodule Rotn.Cipher do
  @starting_symbol ?\s
  @ending_symbol ?~

  def encode(text, delta) when is_binary(text) and is_integer(delta),
    do: {:ok, shift(text, delta, shift: :right)}

  def encode(_, delta) when not is_integer(delta), do: {:error, "Incompatible shift value"}
  def encode(_, _), do: {:error, "Cannot encode non-binary"}

  def encode!(text, delta) do
    with {:ok, encoded} <- encode(text, delta) do
      encoded
    else
      {:error, reason} -> raise ArgumentError, reason
    end
  end

  def decode(text, delta) when is_binary(text) and is_integer(delta),
    do: {:ok, shift(text, delta, shift: :left)}

  def decode(_, delta) when not is_integer(delta), do: {:error, "Incompatible shift value"}
  def decode(_, _), do: {:error, "Cannot decode non-binary"}

  def decode!(text, delta) do
    with {:ok, decoded} <- decode(text, delta) do
      decoded
    else
      {:error, reason} -> raise ArgumentError, reason
    end
  end

  defp shift(text, delta, opts \\ [shift: :right])

  defp shift(<<char>> <> text, delta, opts) do
    <<shift_char(char, delta, opts)>> <> shift(text, delta, opts)
  end

  defp shift(_, _, _), do: ""

  defp shift_char(char, delta, shift: direction) when char in @starting_symbol..@ending_symbol do
    rem(char - @starting_symbol + enc_or_dec(direction, delta), @ending_symbol - @starting_symbol) +
      @starting_symbol
  end

  defp shift_char(char, _, _), do: char

  defp enc_or_dec(:right, delta), do: abs(delta)
  defp enc_or_dec(:left, delta), do: @ending_symbol - @starting_symbol - abs(delta)
end
