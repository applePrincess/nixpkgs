{ buildPythonPackage
, fetchPypi
, pythonRelaxDepsHook
, setuptools
, setuptools-scm
, cython
, aiohttp
, aiohttp-cors
, aiokafka
, click
, mode-streaming
, opentelemetry-api
, terminaltables
, yarl
, croniter
, mypy-extensions
, venusian
, intervaltree
}:

buildPythonPackage rec {
  pname = "faust-streaming";
  version = "0.11.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NIi+XewX3NRhPfomALsr+D662wXeRiDcp5HtSgt71lA=";
  };

  build-system = [
    setuptools
    setuptools-scm
    cython
    pythonRelaxDepsHook
  ];

  dependencies = [
    aiohttp
    aiohttp-cors
    aiokafka
    click
    mode-streaming
    # faust-streaming/faust#382
    # opentracing
    opentelemetry-api
    terminaltables
    yarl
    croniter
    mypy-extensions
    venusian
    intervaltree
  ];

  pythonRelaxDeps = [
    "venusian"
  ];
  pythonRemoveDeps = [
    # https://github.com/faust-streaming/faust/commit/ba40e0893cda80b6d89587044ed5a52dcb0d674d
    "six"
    "opentracing"
  ];
}
