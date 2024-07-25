defmodule TestRepo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TestRepoWeb.Telemetry,
      TestRepo.Repo,
      {DNSCluster, query: Application.get_env(:test_repo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TestRepo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TestRepo.Finch},
      # Start a worker by calling: TestRepo.Worker.start_link(arg)
      # {TestRepo.Worker, arg},
      # Start to serve requests, typically the last entry
      TestRepoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestRepo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestRepoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
