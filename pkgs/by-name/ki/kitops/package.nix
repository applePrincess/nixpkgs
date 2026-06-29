{
  lib,
  buildGoModule,
  fetchFromGitHub,
  versionCheckHook,
  stdenv,
}:

buildGoModule (finalAttrs: {
  __structuredAttrs = true;
  pname = "kitops";
  version = "1.15.0";

  src = fetchFromGitHub {
    owner = "kitops-ml";
    repo = "kitops";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ySn91TIkWOd3myjcscmcN0jhbjp0mAYm9R2nG0bnTVo=";
  };

  vendorHash = "sha256-lT1xSuwEZMVjy18pQSuqybfgULyagJX4hCWUYdNrQ8M=";

  subPackages = [ "." ];

  ldflags = [
    "-s"
    "-X github.com/kitops-ml/kitops/pkg/lib/constants.Version=v${finalAttrs.version}"
  ];

  postInstall = ''
    mv $out/bin/kitops $out/bin/kit
  '';

  doCheck = true;
  checkPhase = 
  let
    skippedTests = [
      # TODO: More descriptive reason
      # Tests require network access
      "TestDevCommand"
      "TestDevDirectory"
      "TestDevReferenceExtraction"
      "TestListFormatVariants"
    ] ++ lib.optional stdenv.hostPlatform.isDarwin [
      # Tests require network access
      "TestDevStartOptions_Complete_ReferenceDetection"
      "TestDevStartOptions_Complete_ReferenceDetection/simple_modelkit_reference"
      "TestDevStartOptions_Complete_ReferenceDetection/registry_url_reference"
      "TestDevStartOptions_Complete_ReferenceDetection/localhost_reference"
      "TestDevStartOptions_Complete_ReferenceDetection/reference_with_port_and_path"
      "TestDevStartOptions_Complete_ReferenceDetection/no_arguments_defaults_to_current_directory"
    ];
  in ''
    runHook preCheck
    go test ./... testing -skip="^${builtins.concatStringsSep "|" skippedTests}$" 
    runHook ppostCheck
  '';
  # checkFlags =
  #   let
  #     skippedTests = [
  #       # Tests require network access
  #       "TestDevDirectory"
  #       "TestDevReferenceExtraction"
  #       "TestListFormatVariants"
  #     ];
  #   in
  #   [
  #     "./..."
  #     "testing"
  #     "-skip=^(${builtins.concatStringsSep "|" skippedTests})$"
  #   ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "version";

  # kit's root command resolves a config home directory via $KITOPS_HOME
  # (falling back to XDG-style paths); without it the version subcommand
  # exits before printing its version, so point it at TMPDIR for the check.
  # versionCheckHook wipes the environment unless the var is listed here.
  versionCheckKeepEnvironment = [ "KITOPS_HOME" ];
  preVersionCheck = ''
    export KITOPS_HOME="$TMPDIR"
  '';

  meta = {
    description = "Open source DevOps tool for packaging and versioning AI/ML models, datasets, code, and configuration into an OCI Artifact";
    homepage = "https://github.com/kitops-ml/kitops";
    changelog = "https://github.com/kitops-ml/kitops/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ gbhu753 ];
    mainProgram = "kit";
  };
})
