# Development Journal

This journal records the development of the Azure Secure VM Lab project.

Its purpose is to document the evolution of the project, key engineering decisions, and development milestones. Detailed technical explanations, deployment procedures, security controls and troubleshooting are documented separately.

---

# 2026-07-22

## Session Goal

Design and build a secure Azure Infrastructure as Code project suitable for a cloud engineering portfolio.

---

## Starting Point

The repository had been created but required a defined project scope, repository structure and documentation strategy before implementation could begin.

---

## Work Completed

- Defined the scope for Version 1.0.0.
- Selected Bicep as the Infrastructure as Code language.
- Planned the Azure resource architecture.
- Designed the repository structure.
- Established the documentation framework.
- Created deployment and validation scripts.
- Produced the initial Bicep deployment.
- Created the deployment parameter file.

---

## Design Decisions

- Keep the deployment within a single Bicep file until modularisation becomes beneficial.
- Build a small but fully deployable environment rather than a larger incomplete solution.
- Adopt the standard documentation structure used across portfolio repositories.

---

## Issues Encountered

Minor deployment and configuration issues were identified during implementation.

Detailed investigation and resolutions are documented in **TROUBLESHOOTING.md**.

---

## Documentation Updated

- ARCHITECTURE.md
- README.md

---

## Next Session

Deploy the infrastructure, validate the environment, document implementation details and prepare the Version 1.0.0 release.

---

# 2026-07-23

## Session Goal

Validate the deployed infrastructure, verify security controls and complete the Version 1.0.0 documentation.

---

## Starting Point

The repository structure, Bicep templates and automation scripts were in place, but the environment still required deployment validation, troubleshooting and final documentation before the Version 1.0.0 release.

---

## Work Completed

- Validated successful Bicep deployment.
- Verified Virtual Network and Network Security Group configuration.
- Confirmed SSH key authentication.
- Verified Network Security Group restrictions.
- Connected successfully to the Ubuntu virtual machine.
- Tested deployment validation.
- Confirmed resource cleanup.
- Organised repository screenshots.
- Reviewed documentation for consistency across the repository.

---

## Design Decisions

- Keep troubleshooting information separate from the development journal.
- Store deployment evidence in dedicated documentation rather than the README.
- Use cross-references instead of duplicating technical content.
- Standardise documentation structure across all portfolio repositories.

---

## Issues Encountered

Several genuine deployment and validation issues were identified and resolved during testing.

Full details are recorded in [TROUBLESHOOTING](TROUBLESHOOTING.md)

---

## Documentation Updated

Updated project documentation to reflect Version 1.0.0 implementation and validation.

---

## Next Session

Prepare the Version 1.0.0 release, perform the final repository review and create the Git release tag.

---

## Related Resources

### Infrastructure

- [main.bicep](../bicep/main.bicep)
- [main.bicepparam](../bicep/main.bicepparam)

### Automation

- [deploy.ps1](../scripts/deploy.ps1)
- [validate.ps1](../scripts/validate.ps1)
- [cleanup.ps1](../scripts/cleanup.ps1)

---

## Related Documentation

- [README](../README.md)
- [CHANGELOG](../CHANGELOG.md)
- [ARCHITECTURE](ARCHITECTURE.md)
- [DEPLOYMENT](DEPLOYMENT.md)
- [SECURITY](SECURITY.md)
- [LESSONS LEARNED](LESSONS_LEARNED.md)
- [TROUBLESHOOTING](TROUBLESHOOTING.md)