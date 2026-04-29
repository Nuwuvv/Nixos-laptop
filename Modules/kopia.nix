{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.kopia ];

  systemd.user.services.kopia-backup = {
    description = "Kopia backup snapshot";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kopia}/bin/kopia snapshot create /home/Nuuvv";
    };
  };

  systemd.user.timers.kopia-backup = {
    description = "Kopia backup timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "02:00";
      Persistent = true;
      Unit = "kopia-backup.service";
    };
  };
}

