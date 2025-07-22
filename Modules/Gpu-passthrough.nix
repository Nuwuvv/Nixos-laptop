{ pkgs, lib, config, ... }:
{
  boot = {
    kernelParams = [ 
      # Turn on IOMMU
      "amd_iommu=on"
      # Isolate the GPU
      "vfio-pci.ids=10de:1b06,10de:10ef"
      ]; 
      kernelModules = [ "vfio_pci" "vfio_iommu_type1" "vfio" ];
      blacklistedKernelModules = [ "nvidia" "nouveau" ];
    };
}
