defmodule Helpdesk.Support.PgFile do
  use Ash.Resource,
    extensions: [AshEvents.Events],
    otp_app: :helpdesk,
    domain: Helpdesk.Support,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  events do
    event_log(Helpdesk.Support.PgEvent)
    # ignoring the actions bellow will make the actions work as expected
    # ignore_actions([:create, :update])
  end

  postgres do
    table "files"
    repo Helpdesk.Repo
  end

  policies do
    # Simplified version of plaza's policies to trigger the bug
    policy action_type(:read) do
      # Allow if organization_id matches actor
      forbid_if expr(^actor(:organization_id) != organization_id)
      # Allow if project_id matches actor
      forbid_if expr(^actor(:project_id) != project_id)
      authorize_if always()
    end

    policy action_type(:create) do
      authorize_if always()
    end

    policy action_type(:update) do
      authorize_if always()
    end

    policy action_type(:destroy) do
      authorize_if always()
    end
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_primary_key :id
    attribute :manager_id, :uuid, public?: true
    attribute :name, :string, public?: true
    attribute :enabled, :boolean, public?: true
    attribute :organization_id, :integer, public?: true
    attribute :project_id, :integer, public?: true
    attribute :accept_referral, :boolean, default: false, public?: true
    create_timestamp :created_at
  end

  relationships do
    has_many :contacts, Helpdesk.Support.PgContact, destination_attribute: :file_id
  end

  aggregates do
    count :count_contacts, :contacts
    count :count_contacts_enabled, :contacts, filter: expr(enabled == true)
  end
end
