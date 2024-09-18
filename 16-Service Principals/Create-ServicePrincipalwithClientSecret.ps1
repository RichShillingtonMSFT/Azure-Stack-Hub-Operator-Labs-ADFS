$PEPIP = ''
$AppName = ''
$TenantID = ''

# Connect to PEP Session
$Password = 'PEPPassword' | ConvertTo-SecureString -asPlainText -Force
$PEPCredentials = New-Object System.Management.Automation.PSCredential('AzureStack\CloudAdmin',$Password)

$PEPSession = New-PSSession -ComputerName $PEPIP -ConfigurationName PrivilegedEndpoint -Credential $PEPCredentials -SessionOption (New-PSSessionOption -Culture en-US -UICulture en-US)

# Create Service Principal
$SpObject = Invoke-Command -Session $PEPSession -ScriptBlock {New-GraphApplication -Name $AppName -GenerateClientSecret}

# Create Service Principal Credential Object
$SecurePassword = $SpObject.ClientSecret | ConvertTo-SecureString -AsPlainText -Force

$SPCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SpObject.ClientId, $SecurePassword

# Sign in using the new service principal
Connect-AzAccount -Environment "AzS-Admin" -ServicePrincipal -Credential $SPCredential -Tenant $TenantID

Connect-AzAccount -Environment "AzS-User" -ServicePrincipal -Credential $SPCredential -Tenant $TenantID


# Use the privileged endpoint to update the client secret, used by <AppIdentifier>
$SpObject = Invoke-Command -Session $PEPSession -ScriptBlock {Set-GraphApplication -ApplicationIdentifier "<AppIdentifier>" -ResetClientSecret}

# Output the updated service principal details
$SpObject


# Use the privileged endpoint to get a list of applications registered in AD FS
$AppList = Invoke-Command -Session $PEPSession -ScriptBlock {Get-GraphApplication}

# Use the privileged endpoint to remove application <AppIdentifier>
Invoke-Command -Session $PEPSession -ScriptBlock {Remove-GraphApplication -ApplicationIdentifier "<AppIdentifier>"}