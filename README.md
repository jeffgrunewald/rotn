# Rotn

## Description
A library for applying a shift (sometimes referred to as a Caesar) cipher to 
ASCII characters. All printable characters, as well as the space `\s` are shifted
by the given integer key value.

```
Rotn.encode("foobar", 7)
{:ok, "mvvihy"}
```

Includes a `decode/2` function for reversing your mess when you want to know what
you wrote.

## Why?

Why not?

You need to keep your secrets secret. And while we're at it, we might as well
twist the knife on those who think a simple alphabetic Rot13 will get you there.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rotn` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rotn, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/rotn](https://hexdocs.pm/rotn).

