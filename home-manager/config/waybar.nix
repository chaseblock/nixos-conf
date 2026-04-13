# Adapted from SwayKh's dotfiles

{ lib, pkgs, ... }:

let
  # scripts in https://github.com/theopn/haunted-tiles/tree/niri

  crofi-power = pkgs.writeShellApplication {
    name = "crofi-power";
    runtimeInputs = with pkgs; [ rofi ];
    text = ''
      # Rofi dmenu mode, -i make search case-insensitive, -l is the number of line
      rofi_command() {
        rofi -dmenu -i -config "$HOME/.config/rofi/power.rasi"
      }

      shutdown=" 󰐥 | Shutdown"
      reboot="  | Restart"
      lock="  | Lock"
      suspend=" 󰤄 | Suspend"
      logout=" 󰍂 | Logout"

      chosen=$(echo -e "$shutdown\n$reboot\n$logout\n$suspend\n$lock" | rofi_command)

      case "$chosen" in
      "$shutdown")
        systemctl poweroff
        ;;
      "$reboot")
        systemctl reboot
        ;;
      "$lock")
        swaylock -f
        ;;
      "$suspend")
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
      "$logout")
        niri msg action quit
        ;;
      esac
    '';
  };

in
{
  programs.waybar = {
    enable = true;

    # make sure to launch niri with `niri-session` command
    systemd = {
      enable = true;
      targets = [ "niri.service" ];
    };


    settings = {
      mainBar = {
        id = "cwaybar-niri";
        layer = "top";
        position = "top";
        margin-left = 4;
        margin-right = 4;
        margin-top = 4;
        margin-bottom = 0;
        spacing = 1;
        reload_style_on_change = true;

        modules-left= [
          "niri/workspaces"
          "group/custom-group"
          "niri/window"
        ];
        modules-center = [
        ];
        modules-right = [
          "custom/notification"
          "bluetooth"
          "network"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "pulseaudio"
          "battery"
          "clock"
        ];

        # Left modules

        "niri/workspaces" = {
          format = "{value}";
          current-only = true;
        };

        "group/custom-group" = {
          orientation = "horizontal";
          modules = [
            "tray"
            "idle_inhibitor"
            "custom/power"
          ];
        };

        "niri/window" = {
          format = "{title}";
          max-length = 50;
          icon = true;
          swap-icon-label = false;
        };

        tray = {
          icon-size = 16;
          spacing = 10;
          show-passive-items = true;
          reverse-direction = true;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶 ";
            deactivated = "󰾪 ";
          };
          tooltip-format-activated = "CAFFEINATED";
          tooltip-format-deactivated = "might fall asleep";
        };

        "custom/power" = {
          format = "{icon}";
          format-icons = " ";
          exec-on-event = true;
          on-click = "${lib.getExe crofi-power}";
          tooltip-format = "Power Menu";
        };

        # Right modules

        "custom/notification" = {
          tooltip = true;
          format = " {}";
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        network = {
          # interface = "wlp2*"; # (Optional) To force the use of this interface
          interval = 1;
          format-wifi = " {bandwidthTotalBytes:>2}";
          format-ethernet = " {bandwidthTotalBytes:>2}";
          tooltip-format-ethernet = "󰈀 {ipaddr}";
          tooltip-format-wifi = "  {essid} ({signalStrength}%)";
          tooltip-format = "󰤯 {ifname} via {gwaddr}";
          format-linked = "󰀦 {ifname} (No IP)";
          format-disconnected = "󰀦 Disconnected";
          format-alt = "{ifname}: {gwaddr}/{cidr}";
        };

        cpu = {
          interval = 2;
          format = "  {usage:>2}%";
        };

        memory = {
          interval = 2;
          format = "  {used:0.1f}G/{total:0.1f}G";
        };

        temperature = {
          critical-threshold = 80;
          interval = 2;
          format = " {temperatureC:>2}°C";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        backlight = {
          format = "{icon} {percent:>2}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        pulseaudio = {
          # scroll-step = 1; # %, can be a float
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% 󰂯";
          format-bluetooth-muted = "󰖁 {icon} 󰂯";
          format-muted = "󰖁 {volume}%";
          # format-source = " {volume}%";
          # format-source-muted = "";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󱡒";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          intervali = 2;
        };

        clock = {
          interval = 60;
          format = "  {:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = " {:%a %b %d}";
        };
      };
    };

    style = ''
      /* fragile file path */
      @import url("../../.cache/wal/colors-waybar.css");

      /* Use Pywal16 colors  */
      @define-color fg alpha(@background, 1.0);
      @define-color bg alpha(@foreground, 1.0);
      @define-color bordercolor alpha(@background, 1.0);
      @define-color alert #F14241;
      @define-color disabled #A5A5A5;
      @define-color highlight #D49621;
      @define-color activegreen #26A65B;

      * {
        min-height: 0;
        font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
        font-size: 1rem; /* Adjust font using gtk-font size, like nwg-look or lxappearance */
      }

      window#waybar {
        color: @fg;
        background-color: @bg;
        background: none;
      }
      #window,
      #workspaces {
        color: @bordercolor;
        background-color: @bg;
        border: 0.1rem solid @bordercolor;
        border-radius: 0.5rem;
        padding: 0.1rem 0.5rem;
        margin: 0.1rem;
      }
      #workspaces button {
        color: @bordercolor;
        background-color: @bg;
        border: 0rem solid @bordercolor;
        padding: 0.1rem;
        margin: 0.1rem;
      }

      #clock,
      #cava,
      #battery,
      #bluetooth,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #language,
      #backlight,
      #backlight-slider,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #taskbar,
      #tray,
      #tray menu,
      #tray > .needs-attention,
      #tray > .passive,
      #tray > .active,
      #mode,
      #scratchpad,
      #custom-notification,
      #custom-temp,
      #custom-wifi,
      #custom-kdeconnect,
      #custom-bluetooth,
      #custom-power,
      #custom-separator,
      #custom-group,
      #idle_inhibitor,
      #window,
      #mpd {
        color: @bordercolor;
        background-color: @bg;
        border: 0.1rem solid @bordercolor;
        border-radius: 0.5rem;
        padding: 0.1rem 0.5rem;
        margin: 0.1rem;
      }

      #bluetooth {
        color: @bordercolor;
        background-color: @color1;
      }
      #battery,
      #network {
        color: @bordercolor;
        background-color: @color2;
      }
      #cpu {
        color: @bordercolor;
        background-color: @color3;
      }
      #memory {
        color: @bordercolor;
        background-color: @color4;
      }
      #temperature {
        color: @bordercolor;
        background-color: @color5;
      }
      #custom-notification,
      #backlight {
        color: @bordercolor;
        background-color: @color6;
      }
      #pulseaudio,
      #wireplumber {
        color: @bordercolor;
        background-color: @color3;
      }
      #clock {
        color: @bordercolor;
        background-color: @color9;
      }

      #workspaces,
      #workspaces button {
        color: @bordercolor;
        background-color: @color4;
      }
      #tray,
      #tray menu,
      #tray > .needs-attention,
      #tray > .passive,
      #tray > .active,
      #custom-wifi,
      #custom-kdeconnect,
      #custom-bluetooth,
      #custom-power,
      #custom-group,
      #idle_inhibitor {
        color: @bordercolor;
        background-color: @color5;
        border: 0rem solid @bordercolor;
      }
      #window {
        color: @bordercolor;
        background-color: @color6;
      }

      #custom-group {
        border: 0.1rem solid @bordercolor;
      }

      #custom-separator {
        color: @disabled;
      }

      #network.disconnected,
      #pulseaudio.muted,
      #wireplumber.muted {
        background-color: @alert;
      }

      #battery.charging,
      #battery.plugged {
        background-color: @activegreen;
      }

      label:focus {
        background-color: @bg;
      }
    '';
  };
}
