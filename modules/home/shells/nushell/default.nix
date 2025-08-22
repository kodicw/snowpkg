{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.shells.nushell;
in
{
  options.${namespace}.shells.nushell = with types;
    {
      enable = mkEnableOption "Whether or not to enable nushell.";
    };

  config =
    mkIf cfg.enable {
      programs = {
        nushell = {
          enable = true;
          shellAliases = {
            "cd" = "z";
            "nixos-rebiuld" = "nr";
          };
        };
        carapace = {
          enable = true;
          enableNushellIntegration = true;
        };
        zoxide = {
          enable = true;
          enableNushellIntegration = true;
        };
        # atuin = {
        #   enable = true;
        #   enableNushellIntegration = true;
        # };
        starship = {
          enable = true;
          settings = {
            format = ''
              [╭╴](2388)$os$username$hostname$directory$git_branch$git_status$git_commit$rust$python$dotnet$kotlin$java$all $battery
              [╰─](238)$character '';
            add_newline = true;
          };
        };
      };
    };
}
