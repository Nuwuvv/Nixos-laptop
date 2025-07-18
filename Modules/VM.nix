{ config, lib, pkgs, modulesPath, ... }:
{
  users.users.Nuuvv.extraGroups = [ "libvirtd" ];
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };
  services.spice-vdagentd.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
    libvirt
  ];
}
