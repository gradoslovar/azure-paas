#Login-AzureRmAccount

# define variables
$location = "westeurope"
$resourceGroup = "teststApp365"

$storageAccountName = "testapp365storage"
$skuName = "Standard_LRS"
$containerName = "resources"

# Create a new resource group.
New-AzureRmResourceGroup -Name $resourceGroup -Location $location 

# Create the storage account.
$storageAccount = New-AzureRmStorageAccount -ResourceGroupName $resourceGroup `
  -Name $storageAccountName `
  -Location $location `
  -SkuName $skuName `
  -Kind StorageV2

# Retrieve the context. 
$ctx = $storageAccount.Context

# Create container that will serve as depo for resource templates...
New-AzureStorageContainer -Name $containerName -Context $ctx -Permission Off

# ... and generate SAS token
$sasToken = New-AzureStorageContainerSASToken -Name $containerName -Context $ctx -Permission rwl
Write-Output "The Storage $($storageAccount.StorageAccountName) and container $containerName are created"
$blobUri = $ctx.BlobEndPoint
Write-Output  "Storage blob URI is: $blobUri"


# Create Azure Key Vault
$vaultName = "app365Vault"

# New-AzureRmResourceGroup -Name $resourceGroup -Location $location
New-AzureRmKeyVault `
  -VaultName $vaultName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -EnabledForTemplateDeployment `
  -Sku Standard
$secretValue = ConvertTo-SecureString $sasToken -AsPlainText -Force
Set-AzureKeyVaultSecret -VaultName $vaultname -Name "containerSasToken" -SecretValue $secretvalue


## to-do Create service principal and add it to key vault access policies
