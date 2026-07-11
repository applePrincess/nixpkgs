{ lib,
  buildPythonPackage,
  fetchPypi,
  pbr,
  setuptools,

  # direct
  keystoneauth1,
  oslo-cache,
  oslo-config,
  oslo-i18n,
  oslo-log,
  oslo-serialization,
  oslo-utils,
  pycadf,
  pyjwt,
  python-keystoneclient,
  requests,
  webob,

  # tests
  oslo-messaging,
  oslotest,
  python-memcached,
  requests-mock,
  stestr,
  testresources,
  webtest,
}:

buildPythonPackage (finalAttrs: {
  pname = "keystonemiddleware";
  version = "13.0.0";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchPypi {
    pname = "keystonemiddleware";
    inherit (finalAttrs) version;
    hash = "sha256-K1Ky+EC+5yVoZm5p+c+Cuc4VWNYSTOJfDyYgg0lLSxk=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    keystoneauth1
    keystoneauth1
    oslo-cache
    oslo-config
    oslo-i18n
    oslo-log
    oslo-serialization
    oslo-utils
    pbr
    pycadf
    pyjwt
    python-keystoneclient
    requests
    webob
  ];

  nativeCheckInputs = [
    oslo-messaging
    oslotest
    python-memcached
    requests-mock
    stestr
    testresources
    webtest
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

})

