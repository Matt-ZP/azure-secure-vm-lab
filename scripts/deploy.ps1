# ------------------------------------------------------------
# Azure Secure VM Lab
# Deploy Infrastructure with Bicep
#
# Optional Parameters:
#   -ResourceGroup   Resource Group name
#   -Location        Azure region
#
# Example:
#   .\deploy.ps1
#
#   .\deploy.ps1 `
#       -ResourceGroup "rg-secure-vm-lab-dev" `
#       -Location "switzerlandnorth"
# ------------------------------------------------------------

param(
    [string]$ResourceGroup = "rg-secure-vm-lab-dev",
    [string]$Location = "switzerlandnorth"
)

Write-Host ""
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "  Azure Secure VM Lab Deployment"
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# Create the Resource Group if it doesn't already exist

New-AzResourceGroup `
    -Name $resourceGroup `
    -Location $location `
    -Force

Write-Host ""
Write-Host "Deploying Bicep template..."
Write-Host ""

New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroup `
    -TemplateFile "../bicep/main.bicep" `
    -TemplateParameterFile "../bicep/main.bicepparam"

$deploymentResult = New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroup `
    -TemplateFile "../bicep/main.bicep" `
    -TemplateParameterFile "../bicep/main.bicepparam"

Write-Host ""
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "        Deployment Summary"
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

if ($deploymentResult.ProvisioningState -eq "Succeeded") {

    Write-Host "Status         : Succeeded" -ForegroundColor Green
    Write-Host "Resource Group : $ResourceGroup"
    Write-Host "VM Name        : $($deploymentResult.Outputs.deployedVmName.Value)"
    Write-Host "Public IP      : $($deploymentResult.Outputs.deployedPublicIp.Value)"
}
else {

    Write-Host "Status         : Failed" -ForegroundColor Red
}