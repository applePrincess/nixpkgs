{
  lib,
  boto3,
  botocore,
  buildPythonPackage,
  fastparquet,
  fetchPypi,
  fsspec,
  hatchling,
  hatch-vcs,
  pandas,
  pyarrow,
  python-dateutil,
  sqlalchemy,
  tenacity,
}:

buildPythonPackage (finalAttrs: {
  pname = "pyathena";
  version = "3.35.4";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchPypi {
    pname = "pyathena";
    inherit version;
    hash = "sha256-WDAHtWbRNGpNJIb6qw4ihY8ZQsRgZKtxuOfpMUbixT0=";
  };

  build-system = [
    hatchling
    hatch-vcs
  ];

  dependencies = [
    boto3
    botocore
    fsspec
    tenacity
    python-dateutil
  ];

  optional-dependencies = {
    pandas = [ pandas ];
    sqlalchemy = [ sqlalchemy ];
    arrow = [ pyarrow ];
    fastparquet = [ fastparquet ];
  };

  # Nearly all tests depend on a working AWS Athena instance,
  # therefore deactivating them.
  # https://github.com/laughingman7743/PyAthena/#testing
  doCheck = false;

  pythonImportsCheck = [ "pyathena" ];

  meta = {
    description = "Python DB API 2.0 (PEP 249) client for Amazon Athena";
    homepage = "https://github.com/laughingman7743/PyAthena/";
    changelog = "https://github.com/laughingman7743/PyAthena/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
})
