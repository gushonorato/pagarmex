defmodule Pagarmex.Config do
  defstruct secret_key: nil

  def get_config!(%__MODULE__{} = config, key) do
    Map.get(config, key) || Application.get_env(:pagarmex, key) ||
      raise "#{key} not configured"
  end
end
