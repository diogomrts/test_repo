defmodule TestRepo.Domain.Generic do
  use Ash.Resource,
    domain: TestRepo.Domain,
    extensions: [AshJsonApi.Resource]

  json_api do
    type("generic")

    routes do
      base "/generic"
      route(:get, "", :create)
    end
  end

  actions do
    action :create, {:array, :struct }do
      constraints items: [instance_of: __MODULE__]

      run fn input, context ->
        {:ok, [%__MODULE__{
          id: 1,
          name: "name"
        }]}
      end
    end
  end

  attributes do
    # integer_primary_key(:id, writable?: true, public?: true)
    attribute(:id, :string, primary_key?: true, allow_nil?: false, public?: true)
    attribute(:name, :string, public?: true)
  end
end
