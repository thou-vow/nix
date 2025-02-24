{ pkgs, ... }:

let
  originFont =
    let
      package = pkgs.nerd-fonts.victor-mono;
      path = "share/fonts/truetype/NerdFonts/VictorMono/VictorMonoNerdFontMono-Light.ttf";
    in
    "${package}/${path}";

  script = pkgs.writeText "modify.pe" ''
    Open($1)
    SelectAll()
    Scale(0.8, 1)
    Generate($2)
    Close()
  '';
in
pkgs.stdenv.mkDerivation {
  pname = "victor-mono-modified";
  version = "1.0";

  src = originFont;

  nativeBuildInputs = [ pkgs.fontforge ];

  unpackPhase = ''
    cp ${script} modify.pe
  '';

  buildPhase = ''
    fontforge -script modify.pe "$src" "VictorMonoModified.ttf"
  '';

  installPhase = ''
    install -Dm644 VictorMonoModified.ttf $out/share/fonts/truetype/VictorMonoModified.ttf
  '';
}
