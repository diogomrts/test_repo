defmodule Helpdesk.Type.Order do
  use Ash.Resource,
    data_layer: :embedded

  attributes do
    attribute :fields, {:array, Helpdesk.Type.Field}, allow_nil?: true, public?: true
    attribute :items_embedded, {:array, Helpdesk.Type.OrderItemEmbedded}, allow_nil?: true, public?: true
    attribute :items_new_type, {:array, Helpdesk.Type.OrderItemInputNewType}, allow_nil?: true, public?: true
  end
end
