defmodule LiveViewPatterns.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveViewPatternsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveViewPatterns.PubSub},
      # Start the task supervisor
      {Task.Supervisor, name: LiveViewPatterns.TaskSupervisor},
      # Start the Repo
      LiveViewPatterns.Repo,
      LiveViewPatterns.Repo.Seeder,
      # Start the Endpoint (http/https)
      LiveViewPatternsWeb.Endpoint
      # Start a worker by calling: LiveViewPatterns.Worker.start_link(arg)
      # {LiveViewPatterns.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewPatterns.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveViewPatternsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
