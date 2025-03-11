defmodule Helpdesk.Type.Field do
  use Ash.Type.NewType,
    subtype_of: :map,
    constraints: [
      fields: [
        fixed: [type: :boolean, default: false],
        type: [type: :string, constraints: [allow_empty?: true]],
        description: [type: :string, allow_nil?: true, constraints: [allow_empty?: true]],
        text: [type: :string, allow_nil?: true, constraints: [allow_empty?: true]],
        value: [type: :string, allow_nil?: true, constraints: [allow_empty?: true]],
        mandatory: [type: :boolean, default: false],
        shown: [type: :boolean, default: false],
        name: [type: :string, constraints: [allow_empty?: true]],
        default_value: [type: :string, source: :defaultValue, constraints: [allow_empty?: true]],
        editable: [type: :boolean, default: false],
      ],
    ]
end
