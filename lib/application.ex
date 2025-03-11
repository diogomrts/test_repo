defmodule Helpdesk.Application do
  use Application
  require Logger

  @impl true
  def start(_type, []) do
    Supervisor.start_link([], [strategy: :one_for_one, name: Helpdesk.Supervisor])
  end
end
