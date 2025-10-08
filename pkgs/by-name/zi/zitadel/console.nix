{
  generateProtobufCode,
  version,
  zitadelRepo,
}:

{
  lib,
  stdenv,
  pnpm,
  nodejs,
  grpc-gateway,
  protoc-gen-connect-go,
  protoc-gen-grpc-web,
  buf,
  fetchFromGitHub,
  pkg-config,
  protobuf_27,
  fetchPnpmDeps,
  pnpmConfigHook,
  protoc-gen-js
}:

let
  protobufGenerated = generateProtobufCode {
    pname = "zitadel-console";
    nativeBuildInputs = [
      grpc-gateway
      protoc-gen-connect-go
      protoc-gen-grpc-web
      protoc-gen-js
    ];
    workDir = "console";
    bufArgs = "../proto --include-imports --include-wkt";
    outputPath = "src/app/proto";
    hash = "sha256-A78to2uARzVvXLMxvZpvm7CLhZM45DaDycGjX/ZvBus=";
  };

  zitadelProtobufGenerated = generateProtobufCode {
    pname = "zitadel-proto";
    workDir = "packages/zitadel-proto";
    bufArgs = "../../proto";
    outputPath = ".";
    hash = "sha256-baPS1wbsUQzelI55zswTPvX7ojXbPts967lwgcZGvlE=";
  };

  client = stdenv.mkDerivation (finalAttrs: {
    pname = "zitadel-client";
    inherit version;
    src = zitadelRepo;

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs) pname version src;
      fetcherVersion = 4;
      hash = "sha256-3CBJpCcQYp6UzIecE7vQK+iqbhmfrESaH6dVf0yRMzU=";
    };

    pnpmWorkspaces = [
      "@zitadel/proto"
      "@zitadel/client"
    ];

    nativeBuildInputs = [
      pnpmConfigHook
      nodejs
      buf
      pnpm
    ];

    preBuild = ''
      cp -r ${zitadelProtobufGenerated}/{cjs,es,types} packages/zitadel-proto
    '';

    buildPhase = ''
      runHook preBuild
      pnpm --filter=@zitadel/client run build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cp -r packages/zitadel-client/dist "$out"
      runHook postInstall
    '';
  });
in
stdenv.mkDerivation (finalAttrs: {
  pname = "zitadel-console";
  inherit version;

  src = zitadelRepo;

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 4;
    hash = "sha256-3CBJpCcQYp6UzIecE7vQK+iqbhmfrESaH6dVf0yRMzU=";
  };

  pnpmWorkspaces = [
    "@zitadel/proto"
    "@zitadel/client"
    "console"
  ];

  nativeBuildInputs = [
    pnpmConfigHook
    nodejs
    buf
    pnpm
  ];

  preBuild = ''
    cp -r ${protobufGenerated} console/src/app/proto
    cp -r ${zitadelProtobufGenerated}/{cjs,es,types} packages/zitadel-proto
    cp -r ${client} packages/zitadel-client/dist
  '';

  buildPhase = ''
    runHook preBuild

    pnpm --filter=console build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r console/dist/console "$out"

    runHook postInstall
  '';
})
