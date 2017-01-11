defmodule Kaggle.Mixfile do
  use Mix.Project

  def project do
    [app: :kaggle,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :simple_bayes, :stemmer]]
  end

  defp deps do
    [
      {:simple_bayes, "~> 0.11.0"},
      {:stemmer,      "~> 1.0"},
      {:csv, "~> 1.4.2"}
    ]
  end
end
