defmodule TestRepo.Contact do
  use Ash.Resource,
    domain: TestRepo.Domain,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshJsonApi.Resource]

  json_api do
    type "contact"
  end

  postgres do
    table "contacts"
    repo TestRepo.Repo
  end

  policies do
    policy action_type(:read) do
      forbid_if expr(phone == "banana")
      authorize_if always()
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :campaign_id, :uuid, public?: true
    attribute :phone, :string, public?: true
    attribute :enabled, :boolean, public?: true
  end

  actions do
    defaults [:read]

    read :available do
      filter expr(enabled)
    end
  end
end
