using './main.bicep'

param location = 'switzerlandnorth'

param vnetName = 'vnet-secure-vm-lab'
param subnetName = 'snet-management'
param nsgName = 'nsg-secure-vm-lab'
param publicIpName = 'pip-secure-vm-lab'
param nicName = 'nic-secure-vm-lab'

param vmName = 'vm-secure-ubuntu'
param vmSize = 'Standard_D2s_v3'
param adminUsername = 'azureuser'

param allowedSshIp = '<authorised-public-ip>/32'

param sshPublicKey = '<ssh-public-key>'
