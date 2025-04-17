#{pkgs ? import <nixpkgs> {}}:
with import <nixpkgs> {};
rustPlatform.buildRustPackage rec  {
  name = "open-mp";
  src = fetchFromGitHub {
    owner = "neetoons";
    rev = "v1.5.2";
    repo = "omp-launcher";
    sha256 = "sha256-UmE82AK82yHmno0f1SSvT7wmcoioFYvpuNPDMuCsuB0=";
  };
      PKG_CONFIG_PATH = "${pkgs.glib}/lib/pkgconfig";

  sourceRoot = "${src.name}/src-tauri"; 
  cargoLock =  {
    lockFile = "${src}/src-tauri/Cargo.lock"; 
    outputHashes = {
        "tauri-plugin-upload-0.0.0" = "sha256-iyJL4B6hvaEu7O7NmB/Bujd3kqB1gcNXH/yWD62b6EE=";
    };
  };
    nativeBuildInputs = [
        pkg-config
        glib
        gtk3
        gdk-pixbuf
        libsoup
        openssl
        webkitgtk
    ];
    buildInputs= [
        nodejs_22
        rustc
        glib
        gtk3
        gdk-pixbuf
        libsoup
        openssl
        webkitgtk

#            libxkbcommon
#    wayland
#    xorg.libX11
#    xorg.libXcursor
#    xorg.libXrandr
#    xorg.libXi
    ];
    yarnOfflineCache = fetchYarnDeps {
        #yarnLock = "${src}/yarn.lock";
        yarnLock = ./yarn.lock;
        hash = "sha256-hVWDidAGeuggZt3PWfXstakj56zw3FawUFp1o2LT6X0=";
    };
    
    yarnBuildHook = ''
    yarn
    yarn tauri build
    '';

  installPhase = ''
    mkdir -p $out
    cp -r ./src-tauri/target/release/* $out/
  '';


  doCheck = false;
}
