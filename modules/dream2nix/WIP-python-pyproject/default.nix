{
  dream2nix,
  config,
  ...
}: {
  imports = [
    ./interface.nix
    dream2nix.modules.dream2nix.buildPythonPackage
  ];

  pyproject =
    builtins.fromTOML
    (builtins.readFile (config.mkDerivation.src + /pyproject.toml));

  mkDerivation = {
    buildInputs =
      config.pyproject.build-system.requires
      or [config.deps.python.pkgs.setuptools];
  };

  buildPythonPackage = {
    pyproject = true;
  };

  name = config.pyproject.project.name;
  version = config.pyproject.project.version;
}
