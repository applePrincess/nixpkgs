{
  lib,
  buildPythonPackage,
  fetchPypi,
  pbr,
  setuptools,

  futurist,
  oslo-config,
  oslo-context,
  oslo-log,
  oslo-utils,
  oslo-serialization,
  oslo-service,
  stevedore,
  debtcollector,
  cachetools,
  webob,
  pyyaml,
  amqp,
  kombu,
  oslo-middleware,
  oslo-metrics,

  callPackage,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-messaging";
  version = "18.2.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_messaging";
    inherit (finalAttrs) version;
    hash = "";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    pbr

    futurist
    oslo-config
    oslo-context
    oslo-log
    oslo-utils
    oslo-serialization
    oslo-service
    stevedore
    debtcollector

    cachetools

    webob

    pyyaml

    amqp
    kombu

    oslo-middleware

    oslo-metrics
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
