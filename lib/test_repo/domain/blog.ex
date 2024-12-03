defmodule TestRepo.Domain.Blog do
  use Ash.Resource,
    domain: TestRepo.Domain,
    extensions: [AshJsonApi.Resource]

  json_api do
    type("blog")

    routes do
      base "/blogs"
      index :read
    end
  end

  actions do
    default_accept(:*)
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id, writable?: true)
    attribute(:name, :string, public?: true)
  end

  relationships do
    has_many :posts, TestRepo.Domain.Post, public?: true
  end
end