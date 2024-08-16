defmodule TestRepo.Support do
  use Ash.Domain, extensions: [AshJsonApi.Domain]

  resources do
    resource(TestRepo.Support.Author)
    resource(TestRepo.Support.Post)
    resource(TestRepo.Support.Blog)
  end
end
