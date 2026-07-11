{
  lib,
  buildPythonPackage,
  fetchPypi,
  pbr,
  setuptools,
  dogpile-cache,
  oslo-config,
  oslo-i18n,
  oslo-log,
  oslo-utils,
  callPackage,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-cache";
  version = "4.3.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_cache";
    inherit (finalAttrs) version;
    hash = "sha256-x0etol4gkldG2jaiCO7FDw1MMQ/KrBC0NraTk+6BQP4=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    dogpile-cache
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
  ];

  # check in passthru.tests.pytest to escape infinite recursion with other oslo components
  doCheck = false;

  # passthru.tests = {
  #   tests = callPackage ./tests.nix { };
  # };

  pythonImportsCheck = [ "oslo_cache" ];

  meta = {
    description = "Oslo Configuration API";
    homepage = "https://github.com/openstack/oslo.cache";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
