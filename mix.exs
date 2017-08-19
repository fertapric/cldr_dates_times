defmodule CldrDatesTimes.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_cldr_dates_times,
      name: "Cldr_Dates_Times",
      source_url: "https://github.com/kipcole9/cldr_dates_times",
      version: @version,
      elixir: "~> 1.5",
      description: description(),
      package: package(),
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  defp description do
    """
    Dates, Times and DateTimes formatting functions for Common Locale Data Repository (CLDR).
    (ex_cldr)[https://hex.pm/packages/ex_cldr] is a dependency.
    """
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_cldr, "~> 0.5.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Kip Cole"],
      licenses: ["Apache 2.0"],
      links: links(),
      files: [
        "lib", "config", "mix.exs", "README*", "CHANGELOG*", "LICENSE*"
      ]
    ]
  end

  def links do
    %{
      "GitHub"    => "https://github.com/kipcole9/cldr_dates_times",
      "Changelog" => "https://github.com/kipcole9/cldr_dates_times/blob/v#{@version}/CHANGELOG.md"
    }
  end

end