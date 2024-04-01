{ inputs, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "autoclicker";
  version = "0.1.7";

  src = inputs.autoclicker;

  cargoHash = "sha256-h4+wan7cmjpMEy7W6pRChx6UlJLqypgl6XMZVL0JlHk=";

  meta = with lib; {
    description = "A simple linux (xorg/wayland) autoclicker!";
    homepage = "https://github.com/konkitoman/autoclicker";
    license = licenses.mit;
    maintainers = [];
  };
}
