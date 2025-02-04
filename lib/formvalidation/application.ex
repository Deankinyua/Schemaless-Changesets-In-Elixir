defmodule Formvalidation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FormvalidationWeb.Telemetry,
      Formvalidation.Repo,
      {DNSCluster, query: Application.get_env(:formvalidation, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Formvalidation.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Formvalidation.Finch},
      # Start a worker by calling: Formvalidation.Worker.start_link(arg)
      # {Formvalidation.Worker, arg},
      # Start to serve requests, typically the last entry
      FormvalidationWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Formvalidation.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FormvalidationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
