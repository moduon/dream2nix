{
  config,
  lib,
  specialArgs,
  dream2nix,
  ...
}: let
  cfg = config.uv;
in {
  imports = [
    ./interface.nix
    dream2nix.modules.dream2nix.env
    dream2nix.modules.dream2nix.WIP-python-pyproject
  ];

  uv = {
    lockRefresh = config.deps.writeShellApplication {
      name = "lock";
      runtimeInputs = [config.deps.uv config.deps.remarshal];
      runtimeEnv = config.env;
      # TODO Instead of remarshal, just dump the sha256 of the lock file
      text = ''
        pushd "$(${config.paths.findRoot})/${config.paths.package}"
        uv lock
        remarshal --if toml -i .${lib.escapeShellArg cfg.lockPath} --of json -o "''${out:?}"
        popd
      '';
    };

    lockContents = builtins.fromTOML (
      builtins.readFile (lib.concatStringsSep "/" [config.paths.projectRoot cfg.lockPath])
    );
  };

  deps = {nixpkgs, ...}:
    lib.mapAttrs (_: lib.mkDefault) {
      inherit (nixpkgs) uv remarshal writeShellApplication;
    };

  env = lib.mapAttrs (_: lib.mkDefault) {
    UV_PYTHON = lib.getExe config.deps.python;

    # Do not download python interpreters
    UV_PYTHON_DOWNLOADS = "never";
  };

  lock = {
    invalidationData = {
      pythonVersion = config.deps.python.version;
      inherit (config) pyproject;
      uvLock = cfg.lockContents;
    };
    fields.uv.script = lib.getExe cfg.lockRefresh;
  };
}
