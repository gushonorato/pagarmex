defmodule Pagarmex.MixProject do
  use Mix.Project

  def project do
    [
      app: :pagarmex,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Pagarmex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.10"},
      {:jason, "~> 1.2"},
      {:plug, "~> 1.13.4"}
    ]
  end
end
