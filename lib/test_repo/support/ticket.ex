defmodule TestRepo.Support.Ticket do
  use Ash.Resource,
    domain: TestRepo.Support,
    extensions: [AshJsonApi.Resource]

  json_api do
    type "widget_data_filter"

    routes do
      base("/widgets-data-filters")

      route :get, "/", :read do
        query_params([
          :campaign_id,
          :file_id,
          :organization_names,
          :project_names,
          :site_names,
          :team_names,
          :agent_names,
          :campaign_names,
          :file_names,
        ])
      end
    end
  end

  resource do
    require_primary_key? false
  end

  attributes do
    attribute :filter_category, :string, public?: true
    attribute :filter_name, :string, public?: true
  end

  actions do
    action :read, {:array, :struct} do
      primary? true
      constraints items: [instance_of: __MODULE__]

      argument :campaign_id, :uuid
      argument :file_id, :uuid
      argument :organization_names, {:array, :string}, default: []
      argument :project_names, {:array, :string}, default: []
      argument :site_names, {:array, :string}, default: []
      argument :team_names, {:array, :string}, default: []
      argument :agent_names, {:array, :string}, default: []
      argument :campaign_names, {:array, :string}, default: []
      argument :file_names, {:array, :string}, default: []

      run fn input, context ->
        {:ok,
         [
           %{
             filter_category: "Category",
             filter_name: "Name",
           }
         ]
        }
      end
    end
  end
end
