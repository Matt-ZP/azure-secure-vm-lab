# ------------------------------------------------------------
# Azure Secure VM Lab
# Remove Resource Group
# ------------------------------------------------------------

param(
    [string]$ResourceGroup = "rg-secure-vm-lab-dev"
)

Write-Host ""
Write-Host "===================================" -ForegroundColor Cyan
Write-Host " Azure Secure VM Lab Cleanup"
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

$confirmation = Read-Host "Delete Resource Group '$ResourceGroup'? (Y/N)"

if ($confirmation -ne "Y") {
    Write-Host ""
    Write-Host "Cleanup cancelled." -ForegroundColor Yellow
    exit
}

Write-Host ""
Write-Host "Deleting Resource Group. This may take several minutes..." `
    -ForegroundColor Yellow

Remove-AzResourceGroup `
    -Name $ResourceGroup `
    -Force | Out-Null

Write-Host ""
Write-Host "Deletion request submitted." -ForegroundColor Green
Write-Host "Resource Group deleted." -ForegroundColor Green