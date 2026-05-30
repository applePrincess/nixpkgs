{ buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # tests
  pytestCheckHook,
}:

buildPythonPackage (finalAttrs: {
  pname = "simp_sexp";
  version = "0.3.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "devbisme";
    repo = "simp_sexp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-g7ziQ04Np2JIJK+MlnxWPEZZTyC4MED/ZKjylyu2OUQ=";
  };

  build-system = [
    setuptools
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];
})
