defmodule TestRepo.Domain do
  use Ash.Domain, extensions: [AshJsonApi.Domain]

  resources do
    resource(TestRepo.Campaign)
    resource(TestRepo.Contact)
  end
end
