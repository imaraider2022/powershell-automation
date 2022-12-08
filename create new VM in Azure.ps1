# Set the Azure subscription and resource group
$subscriptionID = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
$resourceGroup = "my-resource-group"

# Set the virtual machine details
$vmName = "my-vm"
$location = "West US"
$vmSize = "Standard_D2s_v3"
$osDiskName = "my-vm-osdisk"
$osDiskSizeGB = 128
$adminUsername = "azureuser"
$adminPassword = "P@ssw0rd!"

# Set the Windows Server 2022 image details
$publisher = "MicrosoftWindowsServer"
$offer = "WindowsServer"
$sku = "2022-Datacenter"
$version = "latest"

# Select the Azure subscription
Select-AzureSubscription -SubscriptionId $subscriptionID

# Get the Windows Server 2022 image
$image = Get-AzureVMImage | where {
  $_.PublisherName -eq $publisher -and
  $_.Offer -eq $offer -and
  $_.Skus -contains $sku -and
  $_.Version -eq $version
}

# Create a new Azure virtual machine
New-AzureVM -Name $vmName -Location $location -VMSize $vmSize -ImageName $image.ImageName -OSDiskName $osDiskName -OSDiskSizeInGB $osDiskSizeGB -AdminUsername $adminUsername -AdminPassword $adminPassword
