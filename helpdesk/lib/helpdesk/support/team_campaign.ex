defmodule Helpdesk.Support.TeamCampaign do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "teams_campaigns"
    repo Helpdesk.Repo
  end

  attributes do
    attribute :team_id, :uuid, primary_key?: true, allow_nil?: false, public?: true
    attribute :campaign_id, :uuid, primary_key?: true, allow_nil?: false, public?: true
    attribute :restricted, :boolean, public?: true
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  relationships do
    belongs_to :team, Helpdesk.Support.Team, public?: true
    belongs_to :campaign, Helpdesk.Support.Campaign, public?: true
  end
end
