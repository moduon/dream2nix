{
  lib,
  specialArgs,
  dream2nix,
  ...
}: let
  mkSubmodule = import ../../../lib/internal/mkSubmodule.nix {inherit lib specialArgs;};
  t = lib.types;
in {
  options.uv = mkSubmodule {
    options = {
      lockRefresh = lib.mkOption {
        type = t.package;
        description = ''
          The script to lock the environment
        '';
      };

      lockPath = lib.mkOption {
        type = t.path;
        default = "/uv.lock";
        description = ''
          The path to the lock file
        '';
      };

      lockContents = lib.mkOption {
        type = t.attrsOf t.anything;
        description = ''
          The parsed contents of the uv.lock file
        '';
      };
    };
  };
}
