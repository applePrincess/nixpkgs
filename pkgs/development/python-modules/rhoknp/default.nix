{ lib
, buildPythonPackage
, fetchPypi
, poetry-core
, typing-extensions
, typer
, pyyaml
, rich
, uvicorn
, fastapi
, jinja2
, pygments
}:

buildPythonPackage rec {
  pname = "rhoknp";
  version = "1.7.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-4n+u8xIXPatgu6mAMQXdOJW7pTxfK2v4TVb958bVFXE=";
  };

  build-system = [ poetry-core ];

  optinal-dependencies = [
    typing-extensions
    typer
    pyyaml
    rich
    uvicorn
    fastapi
    jinja2
    pygments
  ];

  buildDependencies = [

  ];
}
