# Set the Azure tenant ID and the Google Workspace domain
$tenantID = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
$domain = "your-domain.com"

# Set the user details
$firstName = "John"
$lastName = "Doe"
$displayName = "$firstName $lastName"
$userPrincipalName = "$firstName.$lastName@$domain"
$password = "P@ssw0rd!"

# Create a new user in Azure Active Directory
New-AzureADUser -DisplayName $displayName -FirstName $firstName -LastName $lastName -UserPrincipalName $userPrincipalName -Password $password

# Connect to the Google Workspace API
$googleApiKey = "Your_Google_API_Key"
$googleWorkspaceUrl = "https://www.googleapis.com/admin/directory/v1/users"
$headers = @{ "Authorization" = "Bearer $googleApiKey" }

# Create the user in Google Workspace using the details from Azure Active Directory
$body = @{
  "primaryEmail" = $userPrincipalName
  "name" = @{
    "givenName" = $firstName
    "familyName" = $lastName
    "fullName" = $displayName
  }
  "password" = $password
}

$response = Invoke-RestMethod -Method Post -Uri $googleWorkspaceUrl -Headers $headers -Body $body

# Check the response to see if the user was created successfully
if ($response.id) {
  Write-Output "User created successfully in Google Workspace"
} else {
  Write-Error "Failed to create user in Google Workspace"
}
