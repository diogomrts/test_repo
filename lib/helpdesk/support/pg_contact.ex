defmodule Helpdesk.Support.PgContact do
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Support,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "contacts"
    repo Helpdesk.Repo
  end

  policies do
    # This policy creates the OR condition that triggers the bug
    policy action_type(:read) do
      # Allow if project_id matches OR team_id is null
      authorize_if expr(^actor(:project_id) == project_id or is_nil(team_id))
    end

    policy action_type(:create) do
      authorize_if always()
    end
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_primary_key :id
    attribute :file_id, :uuid, public?: true, allow_nil?: false
    attribute :project_id, :integer, public?: true
    attribute :team_id, :uuid, public?: true
    attribute :enabled, :boolean, default: false, public?: true
    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :file, Helpdesk.Support.PgFile, define_attribute?: false
  end
end
