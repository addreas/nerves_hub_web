defmodule Mix.Tasks.Assets.CopyStatic do
  use Mix.Task

  @shortdoc "Copy satic web assets"
  @assets_static Path.expand("../../../assets/static", __DIR__)
  @priv_static Path.expand("../../../priv/static", __DIR__)

  def run(_) do
    File.cp_r!(@assets_static, @priv_static)
  end
end
