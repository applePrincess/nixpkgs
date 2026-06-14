{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  libiconv,
  dirty-equals,
  pytest-benchmark,
  pytestCheckHook,
  rustPlatform,
}:

buildPythonPackage rec {
  pname = "rtoml";
  version = "0.13";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "samuelcolvin";
    repo = "rtoml";
    rev = "v${version}";
    hash = "sha256-QrGoMxNGKQS0En2txZq+mxxWpzwLbHRxqdsAZ1J/bcc=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-qHd82jdOyaIqVFFt+ZrHIH0EPwlLJpCFCrx15DN5Rig=";
  };

  build-system = with rustPlatform; [
    cargoSetupHook
    maturinBuildHook
  ];

  buildInputs = [ libiconv ];

  pythonImportsCheck = [ "rtoml" ];

  nativeCheckInputs = [
    dirty-equals
    pytest-benchmark
    pytestCheckHook
  ];

  pytestFlags = [ "--benchmark-disable" ];

  disabledTests = [
    # TypeError: loads() got an unexpected keyword argument 'name'
    "test_load_data_toml"
  ];

  preCheck = ''
    rm -rf rtoml
  '';

  meta = {
    description = "Rust based TOML library for Python";
    homepage = "https://github.com/samuelcolvin/rtoml";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
