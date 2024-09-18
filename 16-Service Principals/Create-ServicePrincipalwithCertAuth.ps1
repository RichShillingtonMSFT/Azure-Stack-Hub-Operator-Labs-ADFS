$PEPIP = ''
$AppName = ''
$TenantID = ''

# Connect to PEP Session
$Password = 'PEPPassword' | ConvertTo-SecureString -asPlainText -Force
$PEPCredentials = New-Object System.Management.Automation.PSCredential('AzureStack\CloudAdmin',$Password)

$PEPSession = New-PSSession -ComputerName $PEPIP -ConfigurationName PrivilegedEndpoint -Credential $PEPCredentials -SessionOption (New-PSSessionOption -Culture en-US -UICulture en-US)

# Create New Self signed cert
$NewCert = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\My" -Subject "CN=$AppName" -KeySpec KeyExchange

$Cert = Get-Item "Cert:\CurrentUser\My\$($NewCert.Thumbprint)"

# Create Service Principal
$SpObject = Invoke-Command -Session $PEPSession -ScriptBlock {New-GraphApplication -Name "$Using:AppName" -ClientCertificates $using:cert}

# Create Service Principal Credential Object

# Sign in using the new service principal
Connect-AzAccount -Environment "Azs-User" -ServicePrincipal -CertificateThumbprint $SpObject.Thumbprint -ApplicationId $SpObject.ClientId -TenantId $TenantID

Connect-AzAccount -Environment "Azs-User" -ServicePrincipal -CertificateThumbprint $SpObject.Thumbprint -ApplicationId $SpObject.ClientId -TenantId $TenantID

# Use the privileged endpoint to update the client secret, used by <AppIdentifier>
$SpObject = Invoke-Command -Session $PEPSession -ScriptBlock {Set-GraphApplication -ApplicationIdentifier "<AppIdentifier>" -ClientCertificates $using:NewCert}

# Output the updated service principal details
$SpObject


# Use the privileged endpoint to get a list of applications registered in AD FS
$AppList = Invoke-Command -Session $PEPSession -ScriptBlock {Get-GraphApplication}

# Use the privileged endpoint to remove application <AppIdentifier>
Invoke-Command -Session $PEPSession -ScriptBlock {Remove-GraphApplication -ApplicationIdentifier "<AppIdentifier>"}