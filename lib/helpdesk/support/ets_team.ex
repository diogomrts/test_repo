defmodule Helpdesk.Support.EtsTeam do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:read, create: :*, update: :*]
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, public?: true
    attribute :enabled, :boolean, public?: true
  end

  relationships do
    has_many :users, Helpdesk.Support.EtsUser, destination_attribute: :team_id
  end

  aggregates do
    count :enabled_users, :users, filter: expr(enabled == true)
  end
end
