# europeext.nix

# make a  derivation for berkeley-mono font installation
{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "europeext-regular";
  version = "1";

  src = ../../assets/europeext-regular_VDgvm.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 europeext-regular/*.otf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}

