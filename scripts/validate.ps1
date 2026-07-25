# ------------------------------------------------------------
# Azure Secure VM Lab
# Validate Infrastructure with Bicep
#
# Optional Parameters:
#   -ResourceGroup   Resource Group name
#   -Location        Azure region
#
# Example:
#   .\validate.ps1
#
#   .\validate.ps1 `
#       -ResourceGroup "rg-secure-vm-lab-dev" `
#       -Location "switzerlandnorth"
# ------------------------------------------------------------

param(
    [string]$ResourceGroup = "rg-secure-vm-lab-dev",
    [string]$Location = "switzerlandnorth"
)

Write-Host ""
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "  Azure Secure VM Lab Validation"
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# Check whether the Resource Group exists

$existingResourceGroup = Get-AzResourceGroup `
    -Name $ResourceGroup `
    -ErrorAction SilentlyContinue

if ($null -eq $existingResourceGroup) {

    Write-Host "Resource Group '$ResourceGroup' does not exist." `
        -ForegroundColor Yellow

    Write-Host ""
    Write-Host "An empty Resource Group is required before Azure can"
    Write-Host "validate a Resource Group deployment."
    Write-Host ""

    $selection = Read-Host "Create it now? [Y] Yes  [N] No  [Q] Quit"

    switch ($selection.ToUpper()) {

        "Y" {
            Write-Host ""
            Write-Host "Creating Resource Group..." -ForegroundColor Yellow

            New-AzResourceGroup `
                -Name $ResourceGroup `
                -Location $Location `
                -Force | Out-Null

            Write-Host "Resource Group created." -ForegroundColor Green
        }

        "N" {
            Write-Host ""
            Write-Host "Validation cancelled." -ForegroundColor Yellow
            exit
        }

        "Q" {
            Write-Host ""
            Write-Host "Exiting validation script." -ForegroundColor Yellow
            exit
        }

        default {
            Write-Host ""
            Write-Host "Invalid selection. Validation cancelled." `
                -ForegroundColor Red
            exit
        }
    }
}

Write-Host ""
Write-Host "Validating Bicep deployment..."
Write-Host ""

$validationResult = Test-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroup `
    -TemplateFile "../bicep/main.bicep" `
    -TemplateParameterFile "../bicep/main.bicepparam"

if ($null -eq $validationResult) {

    Write-Host ""
    Write-Host "Validation succeeded." -ForegroundColor Green
}
else {

    Write-Host ""
    Write-Host "Validation failed." -ForegroundColor Red
    Write-Host ""

    $validationResult | Format-List
}