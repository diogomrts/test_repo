defmodule TestRepo.Repo do
  use Ecto.Repo,
    otp_app: :test_repo,
    adapter: Ecto.Adapters.Postgres
end
