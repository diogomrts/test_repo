defmodule Helpdesk.Support.EtsTeam do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: Ash.DataLayer.Ets

  attributes do
    uuid_primary_key :id
    attribute :name, :string, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
  end
end
