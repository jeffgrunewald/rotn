defmodule Rotn do
  @moduledoc """
  Rotn takes a compatible binary and an integer value and rotates
  the corresponding characters of the binary by the integer value
  around a circle of ASCII values from 32 - 126 inclusive.
  """

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
  @spec encode(binary(), integer()) :: {:ok | :error, binary()}
  defdelegate encode(text, delta), to: Rotn.Cipher, as: :encode

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
  @spec encode!(binary(), integer()) :: binary() | no_return()
  defdelegate encode!(text, delta), to: Rotn.Cipher, as: :encode!

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
  @spec decode(binary(), integer()) :: {:ok | :error, binary()}
  defdelegate decode(text, delta), to: Rotn.Cipher, as: :decode

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
  @spec decode!(binary(), integer()) :: binary() | no_return()
  defdelegate decode!(text, delta), to: Rotn.Cipher, as: :decode!

end
