defmodule Helpdesk.Support do
  use Ash.Domain,
    otp_app: :helpdesk,
    extensions: [AshJsonApi.Domain]

  resources do
    resource Helpdesk.Support.User
    resource Helpdesk.Support.Team
  end
end
