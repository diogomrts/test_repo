defmodule TestRepo.Domain do
  use Ash.Domain, extensions: [AshJsonApi.Domain]

  resources do
    resource(TestRepo.Domain.Author)
    resource(TestRepo.Domain.Post)
    resource(TestRepo.Domain.Blog)
    resource(TestRepo.Domain.Generic)
  end
end
