{ buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, setuptools
, setuptools-scm
, colorlog
, croniter
, mypy-extensions
}:

buildPythonPackage rec {
  pname = "mode-streaming";
  version = "0.4.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "faust-streaming";
    repo = "mode";
    tag = version;
    hash = "sha256-6DbM20RHBovPbaB8QMQhw88u2rLvNoY/EgCinjvUxa0=";
  };

  build-system = [
    setuptools
    setuptools-scm
    pythonRelaxDepsHook
  ];

  dependencies = [
    colorlog
    croniter
    mypy-extensions
  ];

  pythonRelaxDeps = [
    "croniter"
  ];
}
