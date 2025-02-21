defmodule Helpdesk.Support.User do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo Helpdesk.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :team_id, :uuid, public?: true

    attribute :name, :string, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
  end

  relationships do
    belongs_to :team, Helpdesk.Support.Team, public?: true

    has_many :campaigns, Helpdesk.Support.Campaign do
      no_attributes? true
      filter expr(not user_restricted(user_id: parent(id), team_id: parent(team_id)))
    end
  end
end
