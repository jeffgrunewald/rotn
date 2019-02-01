defmodule Rotn do
  @moduledoc """
  Rotn takes a compatible binary and an integer value and rotates
  the corresponding characters of the binary by the integer value
  around a circle of ASCII values from 32 - 126 inclusive.
  """

  @starting_symbol ?\s
  @ending_symbol ?~

  @doc ~S"""
  Returns an `{:ok, "encoded string"}` tuple.

  ## Examples

      iex> Rotn.encode("I must not fear", 13)
      {:ok, "V-z$\"#-{|#-srn!"}

      iex> Rotn.encode(68.9, 13)
      {:error, "Cannot encode non-binary"}

      iex> Rotn.encode("the water belongs to the tribe", 2.5)
      {:error, "Incompatible shift value"}

      iex> Rotn.encode("Fear is the mindkiller", -20)
      {:ok, "Zyu(4})4*|y4#}$x!}\"\"y("}

  """
  def encode(text, delta) when is_binary(text) and is_integer(delta), do: {:ok, shift(text, delta, shift: :right)}
  def encode(_, delta) when not is_integer(delta), do: {:error, "Incompatible shift value"}
  def encode(_, _), do: {:error, "Cannot encode non-binary"}

  @doc ~S"""
  Returns an encoded string, raising an ArgumentError if the provided
  text cannot be encoded or the shift value is invalid.

  ## Examples

      iex> Rotn.encode!("I must not fear", 13)
      "V-z$\"#-{|#-srn!"

      iex> Rotn.encode!(68.9, 13)
      ** (ArgumentError) Cannot encode non-binary

      iex> Rotn.encode!("the water belongs to the tribe", 2.5)
      ** (ArgumentError) Incompatible shift value
  """
  def encode!(text, delta) do
    with {:ok, encoded} <- encode(text, delta) do
      encoded
    else
      {:error, reason} -> raise ArgumentError, reason
    end
  end

  @doc ~S"""
  Returns an `{:ok, "decoded string"}` tuple.

  ## Examples

      iex> Rotn.decode("V-z$\"#-{|#-srn!", 13)
      {:ok, "I must not fear"}

      iex> Rotn.decode(68.9, 13)
      {:error, "Cannot decode non-binary"}

      iex> Rotn.decode("/# 92z/ -9{ '*)\".9/*9/# 9/-${ ", 2.5)
      {:error, "Incompatible shift value"}

      iex> Rotn.decode("Zyu(4})4*|y4#}$x!}\"\"y(", -20)
      {:ok, "Fear is the mindkiller"}

  """
  def decode(text, delta) when is_binary(text) and is_integer(delta), do: {:ok, shift(text, delta, shift: :left)}
  def decode(_, delta) when not is_integer(delta), do: {:error, "Incompatible shift value"}
  def decode(_, _), do: {:error, "Cannot decode non-binary"}

  @doc ~S"""
  Returns an decoded string, raising an ArgumentError if the provided
  text cannot be decoded or the shift value is invalid.

  ## Examples

      iex> Rotn.decode!("V-z$\"#-{|#-srn!", 13)
      "I must not fear"

      iex> Rotn.decode!(68.9, 13)
      ** (ArgumentError) Cannot decode non-binary

      iex> Rotn.decode!("/# 92z/ -9{ '*)\".9/*9/# 9/-${ ", 2.5)
      ** (ArgumentError) Incompatible shift value
  """
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

  defp shift_char(char, delta, [shift: direction]) when char in @starting_symbol..@ending_symbol do
    rem(char - @starting_symbol + enc_or_dec(direction, delta), 94) + @starting_symbol
  end
  defp shift_char(char, _, _), do: char

  defp enc_or_dec(:right, delta), do: abs(delta)
  defp enc_or_dec(:left, delta), do: (@ending_symbol - @starting_symbol) - abs(delta)
end
