{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  libfaketime,
}:

stdenv.mkDerivation rec {
  version = "0.11";
  pname = "chibi-scheme";

  src = fetchFromGitHub {
    owner = "ashinn";
    repo = "chibi-scheme";
    rev = version;
    sha256 = "sha256-i+xiaYwM7a+0T824VSuh7UUNI6HV9KpqzQPE1WAZ+As=";
  };

  nativeBuildInputs = [
    makeWrapper
    libfaketime
  ];

  makeFlags = [
    "PREFIX=${placeholder "out"}"
  ]
  # ++ lib.optional (!stdenv.hostPlatform.isStatic) [
  #   "STATICFLAGS="
  #   "SEXP_USE_DL=1"
  # ]
  ;

  patches = [
    ./faketime.patch
    ./chibi-scheme-placeholder.patch
    ./print_gc_heap.patch
  ];

  checkTarget = "test-dist";
  # doCheck = true;

  fixupPhase = ''
    wrapProgram "$out/bin/chibi-scheme" \
      --prefix CHIBI_MODULE_PATH : "$out/share/chibi:$out/lib/chibi" \
      ${lib.optionalString stdenv.hostPlatform.isDarwin "--prefix DYLD_LIBRARY_PATH : $out/lib"}

    for f in chibi-doc chibi-ffi; do
      substituteInPlace "$out/bin/$f" \
        --replace-fail "/usr/bin/env chibi-scheme" "$out/bin/chibi-scheme"
    done

     substituteInPlace "$out/bin/snow-chibi" \
       --replace-fail "@chibi-scheme@" "$out/bin/chibi-scheme"

  '';

  meta = {
    homepage = "https://github.com/ashinn/chibi-scheme";
    description = "Small Footprint Scheme for use as a C Extension Language";
    platforms = lib.platforms.all;
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [
      applePrincess
      DerGuteMoritz
    ];
  };
}
