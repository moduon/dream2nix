{lib, ...}: {
  options = {
    pyproject = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = ''
        Parsed contents of the project's pyproject.toml
      '';
      readOnly = true;
    };
  };
}
