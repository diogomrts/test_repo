{ pkgs, lib, ... }:

{
  env.ERL_AFLAGS="-kernel shell_history enabled";

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
