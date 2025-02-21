defmodule Helpdesk.Application do
  use Application
  require Logger

  @impl true
  def start(_type, []) do
    {:ok, pid} = Supervisor.start_link([Helpdesk.Repo], [strategy: :one_for_one, name: Helpdesk.Supervisor])
    Helpdesk.Repo.reset_db_data()
    {:ok, pid}
  end
end
