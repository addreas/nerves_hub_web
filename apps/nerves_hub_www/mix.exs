defmodule NervesHubWWW.MixProject do
  use Mix.Project

  def project do
    [
      app: :nerves_hub_www,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "coveralls.json": :test,
        "coveralls.post": :test,
        docs: :docs
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {NervesHubWWW.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :timex
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(env) when env in [:dev, :test],
    do: ["lib", "test/support", Path.expand("../../test/support")]

  defp elixirc_paths(_),
    do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6-rc", override: true},
      {:phoenix_active_link, git: "https://github.com/jshmrtn/phoenix-active-link.git", branch: "phoenix_html_v3"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.16"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.0.4"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:dart_sass, "~> 0.2", runtime: Mix.env() == :dev},
      {:phoenix_markdown, "~> 1.0"},
      {:plug_cowboy, "~> 2.5"},
      {:gettext, "~> 0.18"},
      {:hackney, "~> 1.17"},
      {:rollbax, "~> 0.11.0"},
      {:floki, ">= 0.27.0", only: :test},
      {:jason, "~> 1.2"},
      {:ansi_to_html, git: "https://github.com/addreas/ansi_to_html.git"},
      {:scrivener_html, git: "https://github.com/addreas/scrivener_html", branch: "phx-1.6"},
      {:nerves_hub_web_core, in_umbrella: true},
      {:nerves_hub_device, in_umbrella: true},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": [
        "ecto.create",
        "ecto.migrate",
        "run ../nerves_hub_web_core/priv/repo/seeds.exs"
      ],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
