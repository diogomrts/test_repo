defmodule Helpdesk.Support do
  use Ash.Domain,
    otp_app: :helpdesk

  resources do
    resource Helpdesk.Support.EtsUser
    resource Helpdesk.Support.EtsTeam
    resource Helpdesk.Support.PgEvent
    resource Helpdesk.Support.PgFile
    resource Helpdesk.Support.PgManager
    resource Helpdesk.Support.PgContact
  end
end
