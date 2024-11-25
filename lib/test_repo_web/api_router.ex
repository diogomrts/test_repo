defmodule TestRepo.JsonApiRouter do
  use AshJsonApi.Router,
    # The api modules you want to serve
    domains: [TestRepo.Domain],
    # optionally an open_api route
    open_api: "/open_api"
end
