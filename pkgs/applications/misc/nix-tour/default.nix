{ lib
, stdenv
, fetchFromGitHub
, electron
, runtimeShell
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "nix-tour";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "nixcloud";
    repo = "tour_of_nix";
    rev = "v${version}";
    sha256 = "09b1vxli4zv1nhqnj6c0vrrl51gaira94i8l7ww96fixqxjgdwvb";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ electron ];

  installPhase = ''
    install -d $out/bin $out/share/nix-tour
    cp -R * $out/share/nix-tour
    makeWrapper ${electron}/bin/electron $out/bin/nix-tour \
      --add-flags $out/share/nix-tour/electron-main.js
  '';

  meta = with lib; {
    description = "'the tour of nix' from nixcloud.io/tour as offline version";
    homepage = "https://nixcloud.io/tour";
    license = licenses.gpl2;
    maintainers = with maintainers; [ qknight yuu ];
  };
}
