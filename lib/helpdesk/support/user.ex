defmodule Helpdesk.Support.User do
  use Ash.Resource, otp_app: :helpdesk, domain: Helpdesk.Support, data_layer: Ash.DataLayer.Ets, extensions: [AshJsonApi.Resource]

  json_api do
    type "user"

    routes do
      route(:post, "/generic", :submit)
    end
  end

  attributes do
    integer_primary_key :id, writable?: true, public?: true
    attribute :name, :string, public?: true
  end

  actions do
    action :submit do
      argument :orders, {:array, Helpdesk.Type.Order}, allow_nil?: true

      run fn input, context ->
        dbg(input.arguments.orders)
        :ok
      end
    end
  end
end
