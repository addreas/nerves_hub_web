defmodule NervesHubWebCore.MixProject do
  use Mix.Project

  def project do
    [
      app: :nerves_hub_web_core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      compilers: Mix.compilers(),
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

  # Specifies which paths to compile per environment.
  defp elixirc_paths(env) when env in [:dev, :test],
    do: ["lib", "test/support", Path.expand("../../test/support")]

  defp elixirc_paths(_),
    do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {NervesHubWebCore.Application, []},
      extra_applications: [:logger, :jason, :inets],
      start_phases: [{:start_workers, []}]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.6"},
      {:phoenix_html, "~> 3.0.4"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_enum, github: "mobileoverlord/ecto_enum"},
      {:plug_cowboy, "~> 2.5"},
      {:bcrypt_elixir, "~> 2.3"},
      {:comeonin, "~> 5.3"},
      {:oban, "~> 2.9"},
      {:crontab, "~> 1.1"},
      {:timex, "~> 3.7"},
      {:sweet_xml, "~> 0.7"},
      {:ex_aws, "~> 2.2"},
      {:ex_aws_s3, "~> 2.3"},
      {:x509, "~> 0.8"},
      {:bamboo, "~> 2.2"},
      {:bamboo_phoenix, "~> 1.0"},
      {:bamboo_smtp, "~> 4.1"},
      {:jason, "~> 1.2"},
      {:mox, "~> 1.0", only: [:test, :dev]},
      {:nimble_csv, "~> 1.1"}
    ]
  end
end
