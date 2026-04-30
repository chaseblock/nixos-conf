{ pkgs, ... }:

{
  home.packages = with pkgs; [
    backrest
    restic
  ];

  systemd.user.services.backrest = {
    Unit = {
      Description = "Restic GUI";
    };

    Service = {
      Environment = [
        "BACKREST_PORT=127.0.0.1:9898"
        "BACKREST_RESTIC_COMMAND=${pkgs.restic}/bin/restic"
      ];
      ExecStart = "${pkgs.backrest}/bin/backrest";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
