{
  fetchFromGitHub,
  fetchNpmDeps,
  lib,
  nodejs,
  npmHooks,
  perl,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cookcli";
  version = "v0.18.1";

  src = fetchFromGitHub {
    owner = "cooklang";
    repo = "cookcli";
    rev = "0cb48078a4065c5c084539c2feb84ed9b01ceaca";
    hash = "sha256-alrmQOt9PY155fIWXmp1m2dfhhkMOd4PkfkBWS2XXRg=";
  };

  cargoHash = "sha256-tYD49UrLzPPS8G2zy2GKFBK4SGYXQ7UEjFWKcHvUTSY=";

  npmDeps = fetchNpmDeps {
    inherit (finalAttrs) src;
    hash = "sha256-HxC9Tf+PZvvETuNqm1W3jaZx7SpYXlxZlI8FwGouK+s=";
  };

  configurePhase = ''
    npm run build-css
  '';

  # Disable self-update:
  # https://github.com/cooklang/cookcli/blob/v0.18.1/README.md#building-without-self-update.
  buildNoDefaultFeatures = true;

  nativeBuildInputs = [
    nodejs
    npmHooks.npmConfigHook
    perl
  ];

  meta = {
    description = "CLI + embedded web-server to work with Cooklang recipes";
    homepage = "https://cooklang.org";
    license = with lib.licenses; [
      mit
    ];
    maintainers = with lib.maintainers; [
    ];
  };
})
