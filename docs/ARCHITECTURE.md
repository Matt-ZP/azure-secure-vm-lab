# Architecture

## Project Overview

The Azure Secure VM Lab deploys a small, security-focused Azure environment containing an Ubuntu virtual machine and the supporting network resources required for secure remote administration.

The infrastructure is defined using Bicep, allowing the Azure environment to be deployed, validated, removed and recreated consistently through supporting PowerShell automation.

The initial release focuses on:

* Azure virtual networking
* Secure SSH access
* Infrastructure as Code
* Resource naming and tagging
* Deployment validation
* Cost-aware resource lifecycle management

---

## Architecture Goals

The architecture is designed to:

* create a reproducible Azure environment
* use secure defaults
* restrict remote access
* avoid password-based authentication
* keep the deployment small and cost-conscious
* separate reusable infrastructure from environment-specific parameters
* support simple deployment and cleanup
* provide a foundation for future monitoring and hardening work

---

## High-Level Architecture

```text
Azure Subscription
│
└── Resource Group
    │
    ├── Virtual Network
    │   │
    │   └── Management Subnet
    │       │
    │       └── Network Interface
    │           │
    │           └── Ubuntu Virtual Machine
    │
    ├── Network Security Group
    │   │
    │   └── Allow SSH from authorised public IP
    │
    └── Public IP Address
```

The virtual machine is connected to a dedicated subnet through a network interface.

A Network Security Group controls inbound access and permits SSH only from an authorised source IP address.

The public IP allows remote administration of the virtual machine during the lab.

---

## Resource Structure

```text
Resource Group
├── Virtual Network
├── Subnet
├── Network Security Group
├── Public IP Address
├── Network Interface
└── Ubuntu Virtual Machine
```

### Resource Group

The resource group contains all resources belonging to the lab.

Keeping the environment within one resource group simplifies:

* deployment management
* cost tracking
* resource discovery
* cleanup
* repeated testing

Deleting the resource group removes the complete lab environment.

---

### Virtual Network

The virtual network provides the private network boundary for the lab.

It contains the subnet used by the virtual machine.

Example address space:

```text
10.10.0.0/16
```

---

### Management Subnet

The subnet contains the network interface used by the Ubuntu virtual machine.

Example subnet prefix:

```text
10.10.1.0/24
```

The subnet is intended for administrative and learning workloads within the lab.

---

### Network Security Group

The Network Security Group controls inbound access to the virtual machine.

For Version 1.0.0, the required inbound rule is:

```text
Source: Authorised public IP
Protocol: TCP
Destination port: 22
Action: Allow
Purpose: SSH administration
```

No other inbound application ports are required.

---

### Public IP Address

The public IP provides temporary remote access to the virtual machine.

It is used only for the lab and should be removed when the resource group is deleted.

Future versions may replace direct public access with Azure Bastion or private connectivity.

---

### Network Interface

The network interface connects the Ubuntu virtual machine to:

* the management subnet
* the Network Security Group
* the public IP address

The network interface acts as the connection point between the virtual machine and the Azure network.

---

### Ubuntu Virtual Machine

The virtual machine provides the Linux environment used for:

* SSH administration
* Linux command-line practice
* Azure administration
* security configuration
* future monitoring and hardening exercises

Authentication uses an SSH public key.

Password authentication is not used.

---

## Resource Dependencies

The main resource dependency order is:

```text
Virtual Network
    │
    ▼
Subnet
    │
    ├──────────────┐
    ▼              ▼
Network Security   Public IP
Group
    │              │
    └──────┬───────┘
           ▼
    Network Interface
           │
           ▼
    Ubuntu Virtual Machine
```

The network interface cannot be created until the following resources exist:

* subnet
* Network Security Group
* public IP address

The virtual machine depends on the network interface.

Bicep determines these dependencies from resource references.

---

## Network Flow

### Inbound Management Traffic

```text
Authorised Administrator
        │
        │ SSH over TCP 22
        ▼
Azure Public IP
        │
        ▼
Network Security Group
        │
        │ Allowed only from authorised IP
        ▼
Network Interface
        │
        ▼
Ubuntu Virtual Machine
```

### Outbound Traffic

```text
Ubuntu Virtual Machine
        │
        ▼
Management Subnet
        │
        ▼
Azure Virtual Network
        │
        ▼
Internet
```

Outbound access allows the virtual machine to reach package repositories and system update services.

---

## Security Design

The initial security model uses the following controls:

* SSH key authentication
* password authentication disabled
* SSH restricted to an authorised public IP
* no unnecessary inbound ports
* no credentials committed to Git
* resource tags applied during deployment
* infrastructure deployed through version-controlled Bicep
* complete environment removable through resource-group deletion

These controls reduce unnecessary exposure while keeping the environment suitable for a small learning lab.

Detailed controls are documented in [SECURITY.md](SECURITY.md)

---

## Infrastructure as Code Design

The environment is deployed using Bicep.

Initial files:

```text
bicep/
├── main.bicep
└── main.bicepparam
```

### `main.bicep`

Defines the Azure resources and their relationships.

### `main.bicepparam`

Provides environment-specific values such as:

* Azure region
* resource names
* address ranges
* VM size
* administrator username
* SSH public key
* authorised source IP
* resource tags

Sensitive values must not be committed to the repository.

---

## Parameterisation

Values that may change between deployments should be defined as parameters rather than hard-coded into resource definitions.

Examples:

```text
location
vmName
adminUsername
sshPublicKey
authorisedSourceIp
vmSize
vnetAddressPrefix
subnetAddressPrefix
tags
```

Parameterisation makes the deployment easier to reuse and reduces the need to edit resource definitions directly.

---

## Naming Strategy

Example naming convention:

```text
Resource Group:                 rg-secure-vm-lab-dev
Virtual Network:                vnet-secure-vm-lab
Subnet:                         snet-management
Network Security Group:         nsg-secure-vm-lab
Public IP:                      pip-secure-vm-lab
Network Interface:              nic-secure-vm-lab
Virtual Machine:                vm-secure-ubuntu
```

Names should be:

* descriptive
* consistent
* lowercase where supported
* easy to associate with the project

---

## Tagging Strategy

```text
environment     = lab
project         = azure-secure-vm-lab
managedBy       = portal
purpose         = portfolio-learning
```

Tags support:

* resource identification
* cost tracking
* governance
* automation
* lifecycle management

---

## Deployment Lifecycle

```text
1. Authenticate to Azure.
2. Select the correct subscription.
3. Create the resource group.
4. Validate the Bicep deployment.
5. Deploy the Bicep template.
6. Confirm resource creation.
7. Connect to the VM using SSH.
8. Complete validation checks.
9. Record evidence and lessons learned.
10. Delete the resource group when testing is complete.
```

---

## Validation Strategy

The deployment is validated using:

* Azure deployment status
* resource inspection
* successful SSH connection
* NSG rule inspection
* outbound connectivity testing
* package repository access
* resource tag verification
* cleanup verification
* successful redeployment

The complete validation process is documented in:

[Validation Checklist](validation-checklist)

---

## Cost Considerations

The lab is designed to minimise unnecessary Azure costs.

Cost controls include:

* using a small VM size
* keeping the environment limited to essential resources
* avoiding unnecessary managed services
* deleting the resource group after testing
* verifying that no resources remain after cleanup

The virtual machine should not remain running when it is not required.

---

## Design Decisions

### ADR-001: Use Bicep

**Status:** Accepted

**Context**

The infrastructure requires a repeatable and version-controlled deployment method.

**Decision**

Use Bicep as the Infrastructure as Code language.

**Consequences**

* Azure resources can be recreated consistently.
* The deployment remains Azure-native.
* Resource dependencies can be expressed clearly.
* Bicep knowledge is directly relevant to Azure administration.

---

### ADR-002: Use SSH Key Authentication

**Status:** Accepted

**Context**

The virtual machine requires secure remote administration.

**Decision**

Use SSH public-key authentication and disable password-based access.

**Consequences**

* Password guessing attacks are reduced.
* Private keys must be protected by the administrator.
* No passwords need to be stored in deployment files.

---

## Known Limitations

Version 1.0.0 intentionally focuses on a small, secure and reproducible Azure environment. The following limitations are deliberate design decisions to keep the first release achievable while providing a solid foundation for future expansion.

| Current Limitation | Planned Improvement |
|--------------------|---------------------|
| Single Bicep deployment file | Refactor into modular Bicep templates |
| Public IP administration | Azure Bastion and private administration |
| No monitoring | Azure Monitor and Log Analytics |
| No alerting | Azure Monitor alert rules |
| Basic access control | RBAC exercises and governance improvements |
| No resource protection | Resource locks and governance policies |
| Basic security configuration | Microsoft Defender for Cloud integration |
| Limited Linux hardening | Additional operating system hardening |
| Manual validation process | Automated deployment validation |
| Bicep only | Terraform implementation for comparison |
| Manual deployment | CI/CD deployment pipeline |
| Single virtual machine | Expanded or multi-tier architecture |

These improvements are planned across future versions of the project as the repository evolves beyond the Version 1.0.0 foundation.

---

## Planned Evolution

```text
Version 1.0.0
Secure Ubuntu VM
        │
        ▼
Version 1.1.0
Monitoring and Log Analytics
        │
        ▼
Version 1.2.0
Governance and RBAC
        │
        ▼
Version 1.3.0
Linux and Azure Security Hardening
        │
        ▼
Version 1.4.0
Automated Validation
        │
        ▼
Version 2.0.0
Expanded or Multi-Tier Architecture
```
---

## Related Resources

### Infrastructure

- [main.bicep](../bicep/main.bicep)
- [main.bicepparam](../bicep/main.bicepparam)

### Images

- [Project Structure](images/v1.0.0/00_Project-Structure.png)

---

## Related Documentation

- [README](../README.md)
- [DEPLOYMENT](DEPLOYMENT.md)
- [DEVELOPMENT_JOURNAL](DEPLOYMENT.md)
- [SECURITY](SECURITY.md)
- [LESSONS LEARNED](LESSONS_LEARNED.md)
