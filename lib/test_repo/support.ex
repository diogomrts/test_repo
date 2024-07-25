defmodule TestRepo.Support do
  use Ash.Domain, extensions: [AshJsonApi.Domain]

  resources do
    resource(TestRepo.Support.Ticket)
  end
end
