{ pkgs, ... }:

# let
#   nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
#     export __NV_PRIME_RENDER_OFFLOAD=1
#     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
#     export __GLX_VENDOR_LIBRARY_NAME=nvidia
#     export __VK_LAYER_NV_optimus=NVIDIA_only
#     exec "$@"
#   '';
# in
{
  services = {
    # tlp.enable = true;
    # auto-cpufreq.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };
  hardware = {
    nvidia = {
      open = false;
      modesetting.enable = true;
      # prime = {
      #   offload.enable = true;
      #   nvidiaBusId = "PCI:23:00:0";
      # };

    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio.support32Bit = true;
  };
  environment = {
    systemPackages = with pkgs; [
      # nvidia-offload
      libva
      libva-utils
      glxinfo
    ];
  };
}
