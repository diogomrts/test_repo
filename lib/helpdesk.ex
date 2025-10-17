defmodule Helpdesk do
  @moduledoc """
  Documentation for `Helpdesk`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Helpdesk.hello()
      :world

  """
  require Ash.Query

  def test do
    manager = Ash.create!(Helpdesk.Support.PgManager, %{name: "name"})
    Ash.create!(Helpdesk.Support.PgFile, %{name: "name", manager_id: manager.id, enabled: false})

    Helpdesk.Support.PgManager
    |> Ash.Query.load([:enabled_files])
    # commenting out the filter returns the value otherwise nil
    |> Ash.Query.filter(enabled_files == 0)
    |> Ash.read_first!()
    |> Map.take([:enabled_files])
  end

  # def test do
  #   team = Ash.create!(Helpdesk.Support.EtsTeam, %{name: "name"})
  #   Ash.create!(Helpdesk.Support.EtsUser, %{name: "name", team_id: team.id, enabled: false})

  #   Helpdesk.Support.EtsTeam
  #   |> Ash.Query.load([:enabled_users])
  #   |> Ash.Query.filter(enabled_users == 0)
  #   |> Ash.read_first!()
  #   |> Map.take([:enabled_users])
  # end
end
