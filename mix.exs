defmodule Reloading.Mixfile do
  use Mix.Project

  def project do
    [app: :reloading,
     version: "1.0.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :exfswatch, :portmidi]]
  end

  defp deps do
    [
      # File-system watching
      {:exfswatch, "~> 0.4.1"},
      # MIDI communication
      {:portmidi, "~> 5.1.1"},
      # Pretty-printing
      {:apex, "~> 1.0.0"}
    ]
  end
end
