# Azure Secure VM Lab

Security-first Azure lab aligned with AZ-104 fundamentals.

## Purpose
This repository documents the design, build, and hardening of a secure Azure virtual machine environment.  
It is intentionally built in stages, with a focus on **least privilege**, **auditability**, and **clean Git history**.

## Repository structure
- `scripts/` – Azure CLI / PowerShell scripts used to create resources
- `docs/` – design notes, screenshots (sanitised), and architecture explanations

## Stages
0. Repo + documentation skeleton
1. Networking (Resource Group, VNet, Subnet, NSG)
2. VM + secure access (SSH keys, no passwords)
3. Governance (tags, RBAC)
4. Monitoring (Log Analytics, alerts)
5. Automation (CLI → optional Terraform)
6. Security hardening (Defender recommendations)

## Safety
No secrets, credentials, private keys, or environment files are stored in this repository.
