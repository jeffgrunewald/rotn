defmodule Rotn.MixProject do
  use Mix.Project

  def project do
    [
      app: :rotn,
      version: "0.2.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "rotn",
      source_url: "https://github.com/jeffgrunewald/rotn"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp description do
    "A simple library to perform a text encoding by rotating characters by n positions."
  end

  defp package do
    [
      maintainers: ["Jeff Grunewald"],
      name: "rotn",
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/jeffgrunewald/rotn"}
    ]
  end
end
