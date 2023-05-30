{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira
      nerdfonts
      twemoji-color-font
      # google-fonts
    ];
    fontconfig = {
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <!-- Default system-ui fonts -->
          <match target="pattern">
            <test name="family">
              <string>system-ui</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>sans-serif</string>
            </edit>
          </match>

          <!-- Default sans-serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>sans-serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <!-- Default serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif CJK SC</string>
              <string>Noto Serif</string>
              <string>Twemoji</string>
            </edit>
        </match>

        <!-- Default monospace fonts-->
        <match target="pattern">
          <test name="family">
            <string>monospace</string>
          </test>
          <edit name="family" mode="prepend" binding="strong">
            <string>FiraCode Nerd Font</string>
            <string>Symbols Nerd Font</string>
            <string>Twemoji</string>
          </edit>
        </match>

          <!-- Replace monospace fonts -->
          <match target="pattern">
            <test name="family" compare="contains">
              <string>Source Code</string>
            </test>
            <edit name="family" binding="strong">
              <string>FiraCode Nerd Font</string>
            </edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Fira Sans</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Fira Sans</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Noto Serif CJK</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };

}