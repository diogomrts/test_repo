defmodule TestRepo.Support.Post do
  use Ash.Resource,
    domain: TestRepo.Support,
    extensions: [AshJsonApi.Resource]

  json_api do
    type("post")
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
    belongs_to :author, TestRepo.Support.Author, public?: true
    belongs_to :blog, TestRepo.Support.Blog, public?: true
  end
end
