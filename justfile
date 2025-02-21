[private]
default:
  @just --list

# first thing to run
project-setup:
  mix local.hex --force
  mix deps.get
# db might not be running so we cant reset?
# @just db-reset

# last resort!
project-reset:
  rm -rf _build/
  # we could delete .elixir_ls/ but then we have to manually restart the extension
  # rm -rf .elixir_ls/
  mix deps.clean --all
  @just db-wipe
  @just project-setup

# run tests and other tests
test:
  @env MIX_ENV=test mix do compile --warnings-as-errors + test --warnings-as-errors

test-wip:
  mix test --only wip

# start postgres in foreground
run-dev-db:
  @start-postgres

run-dev-server:
  iex -S mix

# run interactive elixir shell
run-dev-shell:
  cd helpdesk && iex -S mix

# db should be stopped to run db-wipe
db-wipe:
  rm -rf .devenv/state/postgres/

# db should be running to run db-reset
db-reset:
  env DB_SELECT=LOCAL mix db.reset

# db should be running to run db-data-reset
db-data-reset:
  mix run priv/repo/reset.exs

# db export should be run on prod ro db
db-export:
  env DB_SELECT=PROD_RO mix db.export

# show outdated mix/hex dependencies
outdated:
  mix hex.outdated

# update all mix/hex dependencies
deps-update:
  mix deps.update --all
  # @just mix2nix

# format changed files
format:
  treefmt

# format all files
reformat:
  treefmt -c
