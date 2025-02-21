defmodule Helpdesk.Repo do
  use AshPostgres.Repo, otp_app: :helpdesk

  def min_pg_version do
    %Version{major: 13, minor: 18, patch: 0}
  end

  # Don't open unnecessary transactions
  # will default to `false` in 4.0
  def prefer_transaction? do
    false
  end

  def installed_extensions do
    # Add extensions here, and the migration generator will install them.
    ["ash-functions"]
  end

  def reset_db_data() do
    Helpdesk.Repo.query!("TRUNCATE TABLE users, teams, campaigns, teams_campaigns, teams_campaigns_users RESTART IDENTITY CASCADE")

    c1_id = Ecto.UUID.generate();
    c2_id = Ecto.UUID.generate();
    u1_id = Ecto.UUID.generate();
    u2_id = Ecto.UUID.generate();
    t1_id = Ecto.UUID.generate();

    Logger.info("seeding campaings")
    Ash.Seed.seed!([
      %Helpdesk.Support.Campaign{id: c1_id, name: "campaign1"},
      %Helpdesk.Support.Campaign{id: c2_id, name: "campaign2"},
    ])

    Logger.info("seeding teams")
    Ash.Seed.seed!([
      %Helpdesk.Support.Team{id: t1_id, name: "team1"},
    ])

    Logger.info("seeding users")
    Ash.Seed.seed!([
      %Helpdesk.Support.User{id: u1_id, team_id: t1_id, name: "user1"},
      %Helpdesk.Support.User{id: u2_id, team_id: t1_id, name: "user2"},
    ])

    Logger.info("seeding team campaigns")
    Ash.Seed.seed!([
      %Helpdesk.Support.TeamCampaign{team_id: t1_id, campaign_id: c1_id, restricted: false},
      %Helpdesk.Support.TeamCampaign{team_id: t1_id, campaign_id: c2_id, restricted: false},
    ])

    Logger.info("seeding team campaign users")
    Ash.Seed.seed!([
      %Helpdesk.Support.TeamCampaignUser{team_id: t1_id, user_id: u2_id, campaign_id: c1_id, enabled: false},
      %Helpdesk.Support.TeamCampaignUser{team_id: t1_id, user_id: u1_id, campaign_id: c2_id, enabled: true},
    ])
  end
end
