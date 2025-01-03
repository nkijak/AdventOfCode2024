defmodule Day11.MixProject do
  use Mix.Project

  def project do
    [
      app: :day11,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # mod: {Day11, []},
      extra_applications: [:logger, :tqdm, :observer]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tqdm, "~> 0.0.2", git: "https://github.com/ericentin/tqdm_elixir"}
    ]
  end
end
