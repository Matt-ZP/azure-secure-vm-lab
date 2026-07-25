# Deployment Validation Checklist

This checklist is used to verify that the Azure Secure VM Lab has been deployed securely and successfully.

---

## Resource Validation

- [ ] Resource Group created
- [ ] Virtual Network created
- [ ] Subnet created
- [ ] Network Security Group created
- [ ] Public IP created
- [ ] Network Interface created
- [ ] Ubuntu Virtual Machine deployed successfully

---

## Security Validation

- [ ] SSH key authentication configured
- [ ] Password authentication disabled
- [ ] SSH restricted to authorised public IP
- [ ] No unnecessary inbound NSG rules
- [ ] Resource tags applied
- [ ] No secrets committed to the repository

---

## Connectivity Validation

- [ ] SSH connection successful
- [ ] Internet connectivity confirmed
- [ ] Package repositories reachable

---

## Infrastructure as Code Validation

- [ ] Bicep deployment completed successfully
- [ ] Parameters applied correctly
- [ ] Resource names follow naming convention

---

## Cleanup Validation

- [ ] Resource Group deleted successfully
- [ ] No Azure resources remain after cleanup



