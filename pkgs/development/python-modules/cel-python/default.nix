{
  buildPythonPackage,
  fetchFromGitHub,
  lib,

  # build system
  hatchling,

  # dependencies
  google-re2,
  jmespath,
  lark,
  pendulum,
  pyyaml,

  # tests
  pytestCheckHook,
  protobuf,
}:

buildPythonPackage (finalAttrs: {
  pname = "cel-python";
  version = "0.5";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "cloud-custodian";
    repo = "cel-python";
    tag = "v${finalAttrs.version}";
    hash = "sha256-DPHgHRvzQnBzjl2y9yNWt330xF535dO0iBObuqlr+PI=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    google-re2
    jmespath
    lark
    pendulum
    pyyaml
  ];

  nativeCheckInputs = [
    pytestCheckHook
    protobuf
  ];

  disabledTestPaths = [
    "tools"
    "tests/test_c7n_to_cel.py"
  ];

  meta = {
    description = "Pure Python implementation of the Common Expression Language";
    homepage = "https://cloud-custodian.github.io/cel-python/build/html/index.html";
    changelog = "https://github.com/cloud-custodian/cel-python/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ applePrincess ];
    mainProgram = "cel-python";
  };
})
