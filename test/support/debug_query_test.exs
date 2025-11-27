defmodule Helpdesk.Support.DebugQueryTest do
  @moduledoc """
  Debug test to see the actual SQL query generated.
  """
  use ExUnit.Case, async: false

  alias Helpdesk.Support.{PgFile, PgContact}
  require Ash.Query

  setup do
    # Create a simple actor map
    actor = %{organization_id: 1, project_id: 1, team_id: nil}

    {:ok, file} =
      Ash.create(PgFile, %{
        name: "Test File",
        organization_id: 1,
        project_id: 1,
        accept_referral: false
      })

    {:ok, _contact} =
      Ash.create(PgContact, %{
        file_id: file.id,
        project_id: 1,
        enabled: false
      })

    %{new_file: file, actor: actor}
  end

  test "show generated SQL query", %{new_file: _file, actor: actor} do
    query =
      PgFile
      |> Ash.Query.load([:count_contacts_enabled])
      |> Ash.Query.sort(created_at: :desc, id: :asc)
      |> Ash.Query.filter(accept_referral == false)
      |> Ash.Query.filter(created_at >= ago(365, :day))
      |> Ash.Query.filter(count_contacts_enabled == 0)
      |> Ash.Query.filter(organization_id == 1)
      |> Ash.Query.filter(project_id == 1)
      |> Ash.Query.limit(11)

    # Try to get the data layer query to see SQL
    data_layer_query = Ash.Query.data_layer_query(query, actor: actor)

    IO.puts("\n\n=== DATA LAYER QUERY ===")
    IO.inspect(data_layer_query, label: "Query", limit: :infinity, pretty: true)
    IO.puts("\n\n")

    # Test without pagination
    IO.puts("\n=== WITHOUT PAGINATION ===")
    files = Ash.read!(query, actor: actor)
    assert length(files) >= 0

    # Test with pagination (like plaza)
    IO.puts("\n=== WITH PAGINATION (like plaza) ===")
    query2 =
      PgFile
      |> Ash.Query.load([:count_contacts_enabled])
      |> Ash.Query.sort(created_at: :desc, id: :asc)
      |> Ash.Query.filter(accept_referral == false)
      |> Ash.Query.filter(created_at >= ago(365, :day))
      |> Ash.Query.filter(count_contacts_enabled == 0)
      |> Ash.Query.filter(organization_id == 1)
      |> Ash.Query.filter(project_id == 1)
      |> Ash.Query.limit(11)

    %{results: files2, count: _count} = Ash.read!(query2, actor: actor, page: [limit: 11, count: true])
    assert length(files2) >= 0
  end
end
