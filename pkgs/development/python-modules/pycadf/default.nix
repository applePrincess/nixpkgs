{ lib,
  buildPythonPackage,
  fetchPypi,
  pbr,
  setuptools,

  # direct
  oslo-config,
  oslo-serialization,

  # test
  fixtures,
  pytestCheckHook,
  testtools,
}:

buildPythonPackage (finalAttrs: {
  pname = "pycadf";
  version = "4.1.0";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchPypi {
    pname = "pycadf";
    inherit (finalAttrs) version;
    hash = "sha256-f5vgPndM48yXZ1qsfIB8AXytZ3WWHafpUI91vMn0Mmc=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    oslo-config
    oslo-serialization
  ];

  nativeCheckInputs = [
    fixtures
    pytestCheckHook
    testtools
  ];
})

