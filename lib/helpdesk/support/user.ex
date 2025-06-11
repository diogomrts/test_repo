defmodule Helpdesk.Support.User do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: Ash.DataLayer.Ets, extensions: [AshJsonApi.Resource]

  json_api do
    type "user"

    routes do
      index :read, route: "/read"
      route(:get, "/generic", :submit)
      # route(:post, "/generic", :submit)
    end
  end

  attributes do
    integer_primary_key :id, writable?: true, public?: true
    attribute :name, :string, public?: true
    attribute :date, :naive_datetime, public?: true

    create_timestamp :created_at, type: :naive_datetime, public?: true
  end

  actions do
    defaults create: :*

    read :read do
      primary? true
    end

    action :submit, :struct do
      constraints instance_of: __MODULE__

      run fn input, context ->
        Action.run()
      end
    end
  end
end

defmodule Action do
  def run() do
    {:ok, %Helpdesk.Support.User{
      date: NaiveDateTime.utc_now()
    }}
  end
end
