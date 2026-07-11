{
  lib,
  buildPythonPackage,
  fetchPypi,
  boto3,
  cryptography,
  eventlet,
  greenlet,
  iana-etc,
  installShellFiles,
  libredirect,
  lxml,
  mock,
  pastedeploy,
  pbr,
  pyeclib,
  requests,
  setuptools,
  six,
  stestr,
  python-swiftclient,
  xattr,
  pytestCheckHook,
  requests-mock,

  python-keystoneclient,
}:

buildPythonPackage (finalAttrs: {
  pname = "swift";
  version = "2.37.1";
  pyproject = true;

  src = fetchPypi {
    inherit (finalAttrs) pname version;
    hash = "sha256-d5Jol5iCY8o+Ix+xrviufMLOh3T0UN2bVa+GrsA8D6k=";
  };

  nativeBuildInputs = [ installShellFiles ];

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    cryptography
    eventlet
    greenlet
    lxml
    pastedeploy
    pyeclib
    requests
    six
    xattr
  ];

  nativeCheckInputs = [
    boto3
    libredirect.hook
    mock
    stestr
    python-swiftclient
    requests-mock
    pytestCheckHook
    python-keystoneclient
  ] ++ python-swiftclient.passthru.optional-dependencies.keystone;


  postInstall = ''
    installManPage doc/manpages/*
  '';

  # a lot of tests currently fail while establishing a connection
  # doCheck = true;

  # checkPhase = ''
  #   echo "nameserver 127.0.0.1" > resolv.conf
  #   export NIX_REDIRECTS=/etc/protocols=${iana-etc}/etc/protocols:/etc/resolv.conf=$(realpath resolv.conf)

  #   export SWIFT_TEST_CONFIG_FILE=test/sample.conf

  #   stestr run
  # '';

  pythonImportsCheck = [ "swift" ];

  meta = {
    description = "OpenStack Object Storage";
    homepage = "https://github.com/openstack/swift";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
