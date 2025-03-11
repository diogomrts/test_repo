defmodule Helpdesk.Type.OrderItemEmbedded do
  use Ash.Resource,
    data_layer: :embedded

  attributes do
    attribute :product_id, :integer, allow_nil?: false, public?: true
    attribute :quantity, :integer, allow_nil?: true, default: 1, public?: true
    attribute :fields, {:array, Helpdesk.Type.Field}, allow_nil?: true, public?: true
  end
end

defmodule Helpdesk.Type.OrderItemInputNewType do
  use Ash.Type.NewType,
    subtype_of: :map,
    constraints: [
      fields: [
        product_id: [type: :integer, allow_nil?: false],
        quantity: [type: :integer, allow_nil?: true, default: 1],
        fields: [type: {:array, Helpdesk.Type.Field}, allow_nil?: true],
      ],
    ]
end
