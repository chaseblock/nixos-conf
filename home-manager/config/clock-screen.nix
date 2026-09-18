{ writeShellApplication, coreutils, procps, swaylock, niri }:

# Lock the session and blank the monitors.
writeShellApplication {
  name = "clock-screen";

  runtimeInputs = [ coreutils procps swaylock niri ];

  text = ''
    if ! pgrep -x swaylock > /dev/null 2>&1; then
      swaylock -f
    fi

    # Debounce input
    sleep 1

    # niri turns the monitors back on by itself at the next input event.
    niri msg action power-off-monitors
  '';
}
