defmodule YatzyGame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      YatzyGameWeb.Telemetry,
      YatzyGame.Repo,
      {DNSCluster, query: Application.get_env(:yatzy_game, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: YatzyGame.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: YatzyGame.Finch},
      # Start a worker by calling: YatzyGame.Worker.start_link(arg)
      # {YatzyGame.Worker, arg},
      # Start to serve requests, typically the last entry
      YatzyGameWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: YatzyGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    YatzyGameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
