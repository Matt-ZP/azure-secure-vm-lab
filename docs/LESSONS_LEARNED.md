# Lessons Learned

This document records the key engineering lessons learned during the development of the Azure Secure VM Lab.

The focus is on reusable knowledge and development practices that can be applied to future cloud and infrastructure projects.

---

## Infrastructure as Code

Defining infrastructure as code provides a repeatable and version-controlled deployment process.

Infrastructure should be recreated from source rather than manually configured through the Azure Portal.

---

## Design Before Deployment

Planning the architecture before writing infrastructure code simplifies implementation and reduces unnecessary refactoring.

Documenting design decisions early also provides clear justification for future architectural changes.

---

## Secure Defaults

Security is easier to implement during the initial design than to retrofit later.

Applying secure defaults from the beginning reduces the likelihood of configuration drift and improves the consistency of future deployments.

---

## Infrastructure Validation

Successful deployment does not guarantee a correctly configured environment.

Infrastructure should always be validated after deployment to confirm resources, networking and authentication behave as expected.

---

## Separation of Configuration

Separating infrastructure definitions from deployment-specific configuration improves reusability and reduces the risk of accidental configuration changes.

Using Bicep parameter files makes the deployment more flexible without modifying the infrastructure template.

---

## Documentation as Part of Engineering

Documentation should be developed alongside the project rather than written after implementation.

Separating documentation into focused documents improves maintainability and makes technical information easier to locate.

---

## Troubleshooting as a Learning Tool

Recording genuine issues together with their root cause and resolution creates a reusable knowledge base for future projects.

Troubleshooting documentation should explain why a problem occurred rather than simply recording the final fix.

---

## Reproducibility

Cloud infrastructure should be capable of being deployed, validated, removed and redeployed without manual intervention.

A deployment that cannot be reproduced cannot be considered complete.

---

## Scope Control

A small, fully documented and validated project provides greater portfolio value than a larger project that remains incomplete.

Completing Version 1.0.0 established a stable foundation for future enhancements without introducing unnecessary complexity.

---

## Future Application

The principles established during this project will be applied to future repositories by:

- designing before implementation
- adopting secure-by-default configurations
- validating every deployment
- documenting engineering decisions throughout development
- maintaining consistent documentation standards across repositories
- treating Infrastructure as Code as the authoritative source of infrastructure

---

## Related Documentation

- [README](../README.md)
- [ARCHITECTURE](ARCHITECTURE.md)
- [DEPLOYMENT](DEPLOYMENT.md)
- [SECURITY](SECURITY.md)
- [DEVELOPMENT JOURNAL](DEVELOPMENT_JOURNAL.md)
- [TROUBLESHOOTING](TROUBLESHOOTING.md)
- [CHANGELOG](../CHANGELOG.md)