defmodule Helpdesk.Support.PgFile do
  use Ash.Resource,
    extensions: [AshEvents.Events],
    otp_app: :helpdesk,
    domain: Helpdesk.Support,
    data_layer: AshPostgres.DataLayer

  events do
    event_log Helpdesk.Support.PgEvent
    # ignoring the actions bellow will make the actions work as expected
    # ignore_actions([:create, :update])
  end

  postgres do
    table "files"
    repo Helpdesk.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :manager_id, :uuid, public?: true
    attribute :name, :string, public?: true
    attribute :enabled, :boolean, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
  end
end
