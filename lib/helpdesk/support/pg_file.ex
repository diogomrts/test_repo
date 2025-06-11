defmodule Type.CSVColumnMapping do
   use Ash.Resource,
    data_layer: :embedded

  attributes do
    attribute :column, :integer, allow_nil?: false, public?: true
    attribute :attribute, :string, allow_nil?: false, public?: true
  end
end


defmodule Helpdesk.Support.PgFile do
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Support,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshEvents.Events]

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
    attribute :name, :string, public?: true
    attribute :csv_column_mappings, {:array, Type.CSVColumnMapping}, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
  end
end
