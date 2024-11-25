defmodule TestRepo.Campaign do
    use Ash.Resource,
      domain: TestRepo.Domain,
      data_layer: AshPostgres.DataLayer,
      extensions: [AshJsonApi.Resource]

    json_api do
      type "campaign"

      routes do
        base("/campaigns")
        includes([:contacts])

        index :index
        get(:read)
      end
    end

    postgres do
      table "campaigns"
      repo TestRepo.Repo
    end

    attributes do
      uuid_primary_key :id

      attribute :name, :string, public?: true
    end

    relationships do
      has_many :contacts, TestRepo.Contact,
        source_attribute: :id,
        destination_attribute: :campaign_id,
        read_action: :available,
        public?: true
    end

    actions do
      read :read do
        primary? true
      end

      read :index do
        pagination offset?: true, default_limit: 20, max_page_size: 100
      end
    end

    aggregates do
      count :count_contacts, :contacts, public?: true
    end
  end
