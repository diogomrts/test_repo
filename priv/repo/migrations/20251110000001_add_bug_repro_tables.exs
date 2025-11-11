defmodule Helpdesk.Repo.Migrations.AddBugReproTables do
  @moduledoc """
  Migration for bug reproduction.

  Adds fields to existing files table and creates contacts table
  to reproduce the Ash select_merge bug.
  """
  use Ecto.Migration

  def up do
    alter table(:files) do
      add :organization_id, :integer
      add :project_id, :integer
      add :accept_referral, :boolean, default: false
      add :created_at, :utc_datetime_usec
    end

    create table(:contacts, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :file_id, references(:files, type: :uuid, on_delete: :delete_all), null: false
      add :project_id, :integer
      add :team_id, :uuid
      add :enabled, :boolean, default: false
      add :inserted_at, :utc_datetime_usec, null: false
    end

    create index(:contacts, [:file_id])
    create index(:contacts, [:enabled])
  end

  def down do
    drop table(:contacts)

    alter table(:files) do
      remove :organization_id
      remove :project_id
      remove :accept_referral
      remove :created_at
    end
  end
end
