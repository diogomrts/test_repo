defmodule Helpdesk.Support.PgManager do
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Support,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "managers"
    repo Helpdesk.Repo
  end

  actions do
    defaults [:read, create: :*, update: :*]
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, public?: true
  end

  relationships do
    has_many :files, Helpdesk.Support.PgFile, destination_attribute: :manager_id
  end

  aggregates do
    count :enabled_files, :files, filter: expr(enabled == true)
  end
end
