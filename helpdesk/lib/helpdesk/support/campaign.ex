defmodule Helpdesk.Support.Campaign do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "campaigns"
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
    has_many :team_campaigns, Helpdesk.Support.TeamCampaign, public?: true
    has_many :user_accesses, Helpdesk.Support.TeamCampaignUser, public?: true

    many_to_many :teams, Helpdesk.Support.Team do
      through Helpdesk.Support.TeamCampaign
    end
  end

  calculations do
    calculate :user_restricted, :boolean, Helpdesk.Calculation.CampaignUserRestricted do
      argument :user_id, :uuid, allow_expr?: true
      argument :team_id, :uuid, allow_expr?: true
    end
  end
end

defmodule Helpdesk.Calculation.CampaignUserRestricted do
  use Ash.Resource.Calculation

  @impl true
  def expression(_opts, context) do
    user_id = context.arguments[:user_id]
    team_id = context.arguments[:team_id]

    expr(
      exists(
        user_accesses,
        team_id == ^team_id and user_id == ^user_id and
          campaign_id == ^ref(:campaign_id) and enabled == false
      ) or
        (exists(
          team_campaigns,
           team_id == parent(^team_id) and campaign_id == ^ref(:campaign_id) and
             restricted == true
         ) and
           not exists(
             user_accesses,
             team_id == parent(^team_id) and user_id == parent(^user_id) and
               campaign_id == ^ref(:campaign_id) and enabled == true
           ))
    )
  end
end
