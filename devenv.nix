{ pkgs, lib, ... }:

{
  env.ERL_AFLAGS="-kernel shell_history enabled";

  # https://devenv.sh/scripts/

  scripts.project-setup.exec = "just project-setup";
  scripts.project-reset.exec = "just project-reset";

  scripts.up.exec = "devenv up";

  # instead of running up (or devenv up) we can also run the processes separately:
  scripts.run-dev-db.exec = "just run-dev-db";
  scripts.run-dev-server.exec = "just run-dev-server";

  scripts.db-wipe.exec = "just db-wipe";
  scripts.db-seed.exec = "just db-reset";
  scripts.db-reset.exec = "just db-reset";

  # https://devenv.sh/languages/

  languages.elixir.enable = true;
  languages.javascript.enable = true;

  # https://devenv.sh/packages/

  packages = [
    pkgs.just
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # For ExUnit Notifier on Linux.
    pkgs.libnotify
    # For file_system on Linux.
    pkgs.inotify-tools
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # For ExUnit Notifier on macOS.
    pkgs.terminal-notifier
    # For file_system on macOS.
    pkgs.darwin.apple_sdk.frameworks.CoreFoundation
    pkgs.darwin.apple_sdk.frameworks.CoreServices
  ];

  # https://devenv.sh/processes/

  processes.phx.exec = "mix phx.server";

  # https://devenv.sh/services/

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_16;
    listen_addresses = "127.0.0.1";
    initialScript = ''
      CREATE USER postgres WITH SUPERUSER PASSWORD 'password';
    '';
  };

  cachix.enable = false;
  dotenv.enable = false; # not sure how well this is working (nix-direnv is caching too much or something)
  dotenv.disableHint = true;
}
