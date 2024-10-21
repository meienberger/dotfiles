{ pkgs, config, self, ... }:

{
  system = {
    defaults = {
      dock = {
        autohide = false;
        persistent-apps = [
          "${pkgs.warp-terminal}/Applications/Warp.app"
          "/Applications/Brave Browser.app"
          "/System/Applications/Calendar.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "${pkgs.discord}/Applications/Discord.app"
        ];
      };

      finder = {
        FXPreferredViewStyle = "clmv";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        ShowPathbar = true;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleICUForce24HourTime = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      loginwindow.GuestEnabled = false;
      menuExtraClock.Show24Hour = true;
      screencapture.location = "~/Pictures/screenshots";
    };

    stateVersion = 5;
    # configurationRevision = self.rev or self.dirtyRev or null;

    # Script to copy applications to /Applications
    activationScripts.applications.text =
      let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
      pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';
  };

  time = {
    timeZone = "Europe/Zurich";
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };
}
