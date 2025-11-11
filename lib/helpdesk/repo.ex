defmodule Helpdesk.Repo do
  use AshPostgres.Repo, otp_app: :helpdesk

  # see https://hexdocs.pm/ash_postgres/get-started-with-postgres.html
  def installed_extensions do
    [
      "ash-functions"
      # mentioned in https://hexdocs.pm/ash_phoenix/2.0.0-rc.7/getting-started-with-ash-and-phoenix.html#use-ashpostgres-repo
      # "uuid-ossp",
      # "citext",
    ]
  end

  def min_pg_version do
    %Version{major: 13, minor: 0, patch: 0}
  end
end
