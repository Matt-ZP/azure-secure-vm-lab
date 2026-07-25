# Deployment Guide

This guide describes how to deploy, validate and remove the Azure Secure VM Lab environment.

The deployment uses Infrastructure as Code (IaC) with Bicep and supporting PowerShell scripts to create a repeatable Azure environment.

---

## Deployment Overview

The deployment provisions the following Azure resources:

- Resource Group
- Virtual Network
- Management Subnet
- Network Security Group
- Public IP Address
- Network Interface
- Ubuntu Linux Virtual Machine

Deployment configuration is separated from the infrastructure definition through a Bicep parameter file.

---

## Prerequisites

Before deployment ensure the following software is installed:

- Azure CLI
- Bicep CLI
- PowerShell 7
- Git
- OpenSSH

An active Azure subscription and an SSH key pair are also required.

---

## Repository Components

| Component | Purpose |
|-----------|---------|
| main.bicep | Infrastructure definition |
| main.bicepparam | Deployment parameters |
| deploy.ps1 | Deploys the Azure environment |
| validate.ps1 | Validates the deployment |
| cleanup.ps1 | Removes deployed resources |

---

## Deployment Process

The deployment follows the workflow below.

```text
Authenticate
      │
      ▼
Validate Environment
      │
      ▼
Deploy Infrastructure
      │
      ▼
Verify Deployment
      │
      ▼
Connect via SSH
      │
      ▼
Validate Resources
      │
      ▼
Cleanup
```

---

## Deployment

Authenticate with Azure:

```powershell
az login
```

Deploy the environment:

```powershell
pwsh ./scripts/deploy.ps1
```

The deployment creates all required Azure resources using the Bicep template.

---

## Validation

Validate the deployment:

```powershell
pwsh ./scripts/validate.ps1
```

Validation confirms:

- deployment completed successfully
- expected Azure resources exist
- deployment parameters were applied correctly
- resource naming is correct
- resource tags are present

Additional validation is recorded in the project validation checklist.

---

## SSH Verification

After deployment, connect to the virtual machine using SSH.

Successful authentication confirms:

- the virtual machine is operational
- SSH key authentication is configured correctly
- Network Security Group rules permit authorised access

---

## Cleanup

Remove all deployed resources:

```powershell
pwsh ./scripts/cleanup.ps1
```

Cleanup deletes the Resource Group and all associated Azure resources.

A successful cleanup confirms the environment can be safely removed without leaving unnecessary cloud resources.

---

## Deployment Verification

Version 1.0.0 was verified by confirming:

- successful Bicep deployment
- successful deployment validation
- successful SSH connection
- correct Network Security Group configuration
- successful resource cleanup

Supporting deployment evidence is available in the project image archive under:

docs/images/v1.0.0/deployment/

---

## Related Resources

### Infrastructure

- [main.bicep](../bicep/main.bicep)
- [main.bicepparam](../bicep/main.bicepparam)

### Automation

- [deploy.ps1](../scripts/deploy.ps1)
- [validate.ps1](../scripts/validate.ps1)
- [cleanup.ps1](../scripts/cleanup.ps1)

### Validation

- [VALIDATION CHECKLIST](../tests/validation-checklist.md)

---

## Related Documentation

- [README](../README.md)
- [ARCHITECTURE](ARCHITECTURE.md)
- [SECURITY](SECURITY.md)
- [TROUBLESHOOTING](TROUBLESHOOTING.md)
- [CHANGELOG](../CHANGELOG.md)