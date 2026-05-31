{ buildPythonPackage,
  fetchFromGitHub,

  # dependencies
  simp_sexp,
  hierplace,
}:

buildPythonPackage (finalAttrs: {
  pname = "kinet2pcb";
  version = "1.1.4";

  src = fetchFromGitHub {
    owner = "devbisme";
    repo = "kinet2pcb";
    rev = version;
    hash = "";
  };

  dependencies = [
    simp_sexp
    hierplace
  ];
})
