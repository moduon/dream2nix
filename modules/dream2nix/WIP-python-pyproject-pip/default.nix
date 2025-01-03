{
  dream2nix,
  config,
  ...
}: {
  imports = [
    dream2nix.modules.dream2nix.pip
    dream2nix.modules.dream2nix.WIP-python-pyproject
  ];

  pip.requirementsList = config.pyproject.project.dependencies;
  pip.flattenDependencies = true;
}
