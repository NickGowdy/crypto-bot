defmodule Streamer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Streamer.Binance.start_link("xrpusdt")
      # Starts a worker by calling: Streamer.Worker.start_link(arg)
      # {Streamer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Streamer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end