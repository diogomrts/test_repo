defmodule Helpdesk.Support.PgEvent do
  use Ash.Resource,
    domain: Helpdesk.Support,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshEvents.EventLog]

  postgres do
    table "events"
    repo Helpdesk.Repo
  end

  event_log do
    record_id_type(:string)
  end

  actions do
    defaults [:read]
  end
end
