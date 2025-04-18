defmodule Elidah.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElidahWeb.Telemetry,
      Elidah.Repo,
      {DNSCluster, query: Application.get_env(:elidah, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Elidah.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Elidah.Finch},
      # Start a worker by calling: Elidah.Worker.start_link(arg)
      # {Elidah.Worker, arg},
      # Start to serve requests, typically the last entry
      ElidahWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elidah.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElidahWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
