defmodule ElixirFriends.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_friends,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {ElixirFriends, []},
      applications: [
        :phoenix,
        :phoenix_html,
        :cowboy,
        :logger,
        :phoenix_ecto,
        :postgrex,
        :honeybadger,
        :gettext
      ]
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.1"},
      {:phoenix_ecto, "~> 2.0"},
      {:postgrex, ">= 0.10.0"},
      {:phoenix_html, "~> 2.3"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:cowboy, "~> 1.0"},
      {:extwitter, "~> 0.5.1"},
      {:oauth, github: "tim/erlang-oauth"},
      {:scrivener, "~> 1.1.1"},
      {:honeybadger, "~> 0.3"},
      {:hound, "~> 0.7.4"},
      {:credo, "~> 0.2", only: [:dev, :test]},
      {:gettext, "~> 0.9"}
    ]
  end
end
