[private]
default:
  @just --list

# first thing to run
project-setup:
  mix local.hex --force
  mix deps.get

# last resort!
project-reset:
  rm -rf _build/
  rm -rf deps/
  @just db-wipe
  @just project-setup

# start postgres in foreground
run-dev-db:
  @start-postgres

# run phx server in dev mode in interactive elixir shell
run-dev-server:
  iex -S mix phx.server

# db should be stopped to run db-wipe
db-wipe:
  rm -rf .devenv/state/postgres/

# db should be running to run db-reset
db-reset:
  mix db.reset
