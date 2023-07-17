{ lib
, buildPythonPackage
, fetchFromGitHub
, six
, nose
}:

buildPythonPackage rec {
  pname = "prison";
  version = "unstable-2021-08-26";

  src = fetchFromGitHub {
    owner = "betodealmeida";
    repo = "python-rison";
    rev = "b77e5bc7cb1a198f2cbf0366bf9acc10b8e67dd5";
    hash = "sha256-aCQ2254appVBsKuJgSeraWWyh1d9rt8KDt/f8afpVwo=";
  };

  propagatedBuildInputs = [
    six
  ];

  nativeCheckInputs = [
    nose
  ];

  meta = with lib; {
    description = "Rison encoder/decoder";
    homepage = "https://github.com/betodealmeida/python-rison";
    license = licenses.mit;
    maintainers = [ maintainers.costrouc ];
  };
}
