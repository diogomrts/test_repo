defmodule TestRepo.JsonApiRouter do
  use AshJsonApi.Router,
    # The api modules you want to serve
    domains: [TestRepo.Support],
    # optionally an open_api route
    open_api: "/open_api"
end
