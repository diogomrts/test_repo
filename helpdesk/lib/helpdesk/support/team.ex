defmodule Helpdesk.Support.Team do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "teams"
    repo Helpdesk.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
  end

  relationships do
    has_many :users, Helpdesk.Support.User, public?: true

    many_to_many :campaigns, Helpdesk.Support.Campaign do
      through Helpdesk.Support.TeamCampaign
    end
  end
end
