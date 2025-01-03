# An example package with dependencies locked by uv
{
  config,
  lib,
  dream2nix,
  ...
}: {
  imports = [
    dream2nix.modules.dream2nix.WIP-python-uv
  ];

  mkDerivation.src = ./.;
}
