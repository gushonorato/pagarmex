defmodule Pagarmex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch,
       name: Pagarmex.Finch,
       pools: %{
         :default => [size: 10]
       }}
      # Starts a worker by calling: Pagarmex.Worker.start_link(arg)
      # {Pagarmex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pagarmex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
