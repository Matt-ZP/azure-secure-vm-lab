targetScope = 'resourceGroup'

param location string = resourceGroup().location
param vnetName string = 'vnet-secure-vm-lab'
param subnetName string = 'snet-management'
param nsgName string = 'nsg-secure-vm-lab'
param publicIpName string = 'pip-secure-vm-lab'
param allowedSshIp string
param nicName string = 'nic-secure-vm-lab'
param vmName string = 'vm-secure-ubuntu'
param vmSize string = 'Standard_D2s_v3'
param adminUsername string = 'azureuser'
param sshPublicKey string

var tags = {
  environment: 'lab'
  project: 'azure-secure-vm-lab'
  managedBy: 'bicep'
  purpose: 'portfolio-learning'
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location
  tags: tags

  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: virtualNetwork
  name: subnetName

  properties: {
    addressPrefix: '10.10.1.0/24'
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: nsgName
  location: location
  tags: tags

  properties: {
    securityRules: [
      {
        name: 'Allow-SSH-From-My-IP'

        properties: {
          priority: 300
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: allowedSshIp
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: publicIpName
  location: location
  tags: tags

  sku: {
    name: 'Standard'
  }

  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: nicName
  location: location
  tags: tags

  properties: {
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }

    ipConfigurations: [
      {
        name: 'ipconfig1'

        properties: {
          privateIPAllocationMethod: 'Dynamic'

          subnet: {
            id: subnet.id
          }

          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmName
  location: location
  tags: tags

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }

    securityProfile: {
      securityType: 'TrustedLaunch'

      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
    }

    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }

      osDisk: {
        name: '${vmName}-osdisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        deleteOption: 'Delete'
        diskSizeGB: 30

        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername

      linuxConfiguration: {
        disablePasswordAuthentication: true
        provisionVMAgent: true

        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }

        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: sshPublicKey
            }
          ]
        }
      }
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id

          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }

    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

output deployedVmName string = virtualMachine.name
output deployedPublicIp string = publicIp.properties.ipAddress
output deployedResourceGroup string = resourceGroup().name
