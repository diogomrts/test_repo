defmodule Helpdesk.Support.SelectMergeBugTest do
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

  test "demonstrates select_merge bug with aggregate filtering", %{new_file: _file, actor: actor} do
    # This query should work but fails with:
    # ** (Ecto.QueryError) cannot select_merge source "files" into
    # merge(&0, %{count_contacts_enabled: coalesce(as(1).count_contacts_enabled(), ^0)})

    query =
      PgFile
      |> Ash.Query.load([:count_contacts_enabled, :count_contacts])  # Load aggregates IN the query
      |> Ash.Query.sort(created_at: :desc)
      |> Ash.Query.filter(accept_referral == false)
      |> Ash.Query.filter(created_at >= ago(365, :day))
      |> Ash.Query.filter(count_contacts_enabled == 0)
      |> Ash.Query.filter(organization_id == 1)
      |> Ash.Query.filter(project_id == 1)

    %{results: files, count: _count} =
      Ash.read!(query, actor: actor, page: [limit: 11, offset: 0, count: true])

    assert hd(files).count_contacts_enabled == 0
  end

  test "workaround: load aggregates separately", %{new_file: _file, actor: actor} do
    # Workaround: don't load aggregates in the initial query
    query =
      PgFile
      |> Ash.Query.filter(accept_referral == false)
      |> Ash.Query.filter(created_at >= ago(365, :day))
      |> Ash.Query.filter(count_contacts_enabled == 0)
      |> Ash.Query.filter(organization_id == 1)
      |> Ash.Query.filter(project_id == 1)

    files = Ash.read!(query, actor: actor)

    # Load aggregates separately after the read
    files = Ash.load!(files, [:count_contacts_enabled], actor: actor)

    assert hd(files).count_contacts_enabled == 0
  end
end
