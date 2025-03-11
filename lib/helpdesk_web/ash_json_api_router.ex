defmodule HelpdeskWeb.AshJsonApiRouter do
  use AshJsonApi.Router,
    domains: [Module.concat(["Helpdesk.Support"])],
    open_api: "/open_api"
end
