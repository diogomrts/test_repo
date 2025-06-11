defmodule Helpdesk.Support.EtsUser do
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Support,
    data_layer: Ash.DataLayer.Ets

  attributes do
    uuid_primary_key :id
    attribute :team_id, :uuid, public?: true
    attribute :name, :string, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
  end
end
