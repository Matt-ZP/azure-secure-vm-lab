# Azure Secure VM Lab
Security-first Azure lab aligned with AZ-104 fundamentals.

## Purpose
This repository documents the design, build, and hardening of a secure Azure virtual machine environment.  
It is intentionally built in stages, with a focus on **least privilege**, **auditability**, and **clean Git history**.

## Current Status

✅ Repository structure created

✅ Version tag v0.1 created

🔄 Azure Networking

⏳ Secure VM Deployment

⏳ Monitoring & Alerting

⏳ Infrastructure as Code

⏳ Security Hardening

## Repository Structure

```text
azure-secure-vm-lab
│
├── arm-templates/   Infrastructure as Code templates
├── docs/
│   ├── architecture/      Diagrams and design decisions
│   ├── deployment/        Deployment walkthroughs
│   ├── monitoring/        Azure Monitor and Log Analytics
│   ├── security/          Hardening and security controls
│   └── lessons-learned/   Issues encountered and resolutions
├── screenshots/      Sanitised screenshots and evidence
├── scripts/          Azure CLI and PowerShell scripts
└── README.md
```

## Stages
0. Repo + documentation skeleton
1. Networking (Resource Group, VNet, Subnet, NSG)
2. VM + secure access (SSH keys, no passwords)
3. Governance (tags, RBAC)
4. Monitoring (Log Analytics, alerts)
5. Infrastructure as Code (ARM Templates)
6. Security hardening (Defender recommendations)

## Safety
No secrets, credentials, private keys, or environment files are stored in this repository.

## Engineering Principles
This lab is developed using a CLI-first workflow with deliberate staging, explicit authentication, and cost-aware design.
The focus is on traceability, least privilege, and security-relevant defaults rather than rapid resource creation.
