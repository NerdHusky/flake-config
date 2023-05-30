# (outputs, inputs):
# (outputs):
# {electron}:
{
  # awesome = final: prev: prev.awesome.overrideAttrs (old: {
  #     src = prev.fetchFromGitHub {
  #       owner = "awesomeWM";
  #       repo = "awesome";
  #       rev = "485661b706752212dac35e91bb24a0e16a677b70";
  #       sha256 = "0000000000000000000000000000000000000000000";
  #     };
  #   });

  picom-pjulius = final: prev: prev.picom.overrideAttrs (old: {
    pname = "picom-pijulius";
    version = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
    src = prev.fetchFromGitHub {
      owner = "pijulius";
      repo = "picom";
      rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
      sha256 = "YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
    };
  });

  # authy = self: super: super.authy.overrideAttrs (oldAttrs: rec{
  #   postFixup = /* oldAttrs.postFixup + */ ''
		# makeWrapper ${electron}/bin/electron $out/bin/authy \
	 #      --add-flags $out/resources/app.asar \
		#   --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
  #   '';
  # });
}