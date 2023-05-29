self: super: 
{electron}:
{
  authy = super.authy.overrideAttrs (oldAttrs: rec{
    postFixup = /* oldAttrs.postFixup + */ ''
		makeWrapper ${electron}/bin/electron $out/bin/authy \
	      --add-flags $out/resources/app.asar \
		  --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
    '';
  });

  # authy = super.authy.overrideAttrs (oldAttrs: rec{
  #   postFixup = oldAttrs.postFixup +  ''
		# 	\
		#   --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
  #   '';
  # });
}
