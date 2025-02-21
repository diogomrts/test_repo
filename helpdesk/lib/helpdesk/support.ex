defmodule Helpdesk.Support do
  use Ash.Domain,
    otp_app: :helpdesk

  resources do
    resource Helpdesk.Support.User
    resource Helpdesk.Support.Campaign
    resource Helpdesk.Support.Team
    resource Helpdesk.Support.TeamCampaign
    resource Helpdesk.Support.TeamCampaignUser
  end
end
