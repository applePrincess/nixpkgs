{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,

  kinet2pcb,
  simp_sexp,
  # inspice,
  ply,
  rich,
  graphviz,
}:
buildPythonPackage rec {
  pname = "skidl";
  version = "2.2.3";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "devbisme";
    repo = "skidl";
    tag = "v${version}";
    sha256 = "sha256-LMpimNkEPl/V4OQhJ8hFji5Xy1umhEXAWIELup4U8II=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    # kinet2pcb
    simp_sexp
    # inspice
    ply
    rich
    graphviz
  ];

  pythonRemoveDeps = [
    # Unused but declared as a requirement
    "deprecation"
  ];

  # Checks require availability of the kicad symbol libraries.
  doCheck = false;
  pythonImportsCheck = [ "skidl" ];

  meta = {
    description = "SKiDL is a module that extends Python with the ability to design electronic circuits";
    mainProgram = "netlist_to_skidl";
    homepage = "https://devbisme.github.io/skidl/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ matthuszagh ];
  };
}
