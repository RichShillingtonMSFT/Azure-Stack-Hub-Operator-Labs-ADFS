# Create a Key Vault to Store CloudAdmin Credentials

In Azure you can use Key Vault to store credentials and other secrets. These can be accessed by users and/or applications that have been granted permissions. In this lab we will use PowerShell to create a Key Vault in our Default Provider Subscription and store our Cloud Admin credentials in it. We will then use PowerShell to pull the credentials and use them to connect to our PEP.

## Create a Key Vault and add your Cloud Admin Credentials.

For this lab, you will be connecting to the Azure Resource Manager (ARM) under the AzS-Admin environment. You can use the previous lab See LabFiles\01-Operator Workstation\03-Connect to ARM using PowerShell\01 - Connect to ARM using PowerShell for reference.

1. In a new PowerShell window, connect to the AzS-Admin environment using a device code & administrator@contoso.local credentials.

[](images/Picture1.png)

[](images/Picture2.png)

[](images/Picture3.png)

2. Verify that you are connected to the Default Provider Subscription.

[](images/Picture4.png)

3. Before we create our Key Vault, we need to create a Resource Group. The command to create a Resource Group requires some parameters, such as ResourceGroupName & Location. We will establish PowerShell variables with these answers to use in our new Resource Group command.

```
$AdminKeyVaultResourceGroupName = 'RG-Admin-KV'

$Location = (Get-AzLocation).Location
```

[](images/Picture5.png)

**NOTE**: Each Azure Stack hub is its own location so we can use (Get-AzLocation).Location to pull our location automatically. In Azure Hyperscale you would need to specify the location such as EastUS, WestUS, AzureGovernment.

4. Run the following command to create our Resource Group providing the variables we stored in the prior step.

```
$AdminKeyVaultResourceGroup = New-AzResourceGroup -Name $AdminKeyVaultResourceGroupName -Location $Location
```

[](images/Picture6.png)

**NOTE**: Variables can be manually defined or automatically populated by command outputs. Notice the command we just ran will store its output in the $AdminKeyVaultResourceGroup variable. We will use this output in our next step. If you want to see what was stored in the variable, you can run the variable in your PowerShell window to see the contents.

[](images/Picture7.png)


5. The PowerShell command to create the Key Vault will require some parameters such as VaultName, ResourceGroupName & Location. We will create a variable to store our Vault Name, but for the Resource Group Name & Location we will used the output from our Resource Group variable. We will also store the output from our Key Vault creation command to use in subsequent commands.

```
$AdminKeyVaultName = 'Admin-KeyVault'

$KeyVault = New-AzKeyVault -VaultName $AdminKeyVaultName -ResourceGroupName $AdminKeyVaultResourceGroup.ResourceGroupName -Location $AdminKeyVaultResourceGroup.Location
```

[](images/Picture8.png)

6. Before we can add the secret, we need to set the access policies on our new Key vault. We will need to use some Active Directory PowerShell modules to get the SID of Administrator.

  1. Open and RDP connection to AD-01 (10.100.100.10).
  2. Open and elevated PowerShell window and run the following command:

```
 (Get-ADUser -Identity administrator).SID.value
```

  3. Copy the SID in the output to a notepad file on the ASDK then close RDP.

[](images/Picture9.png)


7. The command to set the Key Vault access policies will require a few parameters including VaultName, ResourceGroupName & the SID we copied from the previous step. We need to create a variable for our SID and we will use our $KeyVault variable for the rest.

Replace SID with the ID you copied to notepad the run the command.

```
$UserObjectID = 'SID'
```

8. Now we run the command to set our access policies to grant our user permissions. The following command will grant ALL access to ALL secrets in the Key vault.

```
 Set-AzKeyVaultAccessPolicy -VaultName $KeyVault.VaultName -ResourceGroupName $KeyVault.ResourceGroupName -ObjectId $UserObjectID -PermissionsToSecrets all -PermissionsToKeys all -PermissionsToCertificates all -PermissionsToStorage all
```

[](images/Picture10.png)


9. Before we can run our command to set the Secret, lets establish variables for our SecretName and our Cloud Admin Password. Use the Lab password when prompted.

```
$CloudAdminSecretName = 'CloudAdminCredential'

$CloudAdminCredential = $host.ui.PromptForCredential("", 'Please provide the Cloud Admin Password to store in the Key Vault', "CloudAdmin", "")
```

[](images/Picture11.png)

10. Lastly, we need to set our secret in our Key Vault.

```
Set-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $CloudAdminSecretName -SecretValue $CloudAdminCredential.Password
```

[](images/Picture12.png)

## Connect to PEP using Key Vault Credentials.

For this lab, you be making a connection to the PEP by providing only your domain user credentials. The password for CloudAdmin will be pulled from our Key vault.

1. Close ALL PowerShell windows.

2. Open a new PowerShell window and connect to the AzS-Admin ARM Environment.

3. Change the variables below, provide the required information then run them in PowerShell:

```
$CloudAdminUserName = 'AzureStack\CloudAdmin'

$AdminKeyVaultName = 'KeyVaultName'

$CloudAdminSecretName = 'SecretName'

$PrivilegedEndpoint = 'PEPIPAddress'
```

[](images/Picture13.png)

4. The next command will pull the secret from Key Vault and display it.

```
$Secret = Get-AzKeyVaultSecret -VaultName $AdminKeyVaultName -Name $CloudAdminSecretName

$Secret
```

[](images/Picture14.png)


5. Instead of displaying it or storing clear text passwords in a variable, we can wrap our command in parenthesis and just pull the piece we need which is SecretValue.|

```
(Get-AzKeyVaultSecret -VaultName $AdminKeyVaultName -Name $CloudAdminSecretName).Secretvalue
```

[](images/Picture15.png)

6. We can combine the previous command with a command to create our credential object for our Cloud Admin.

```
CloudAdminCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $CloudAdminUserName, ((Get-AzKeyVaultSecret -VaultName $AdminKeyVaultName -Name $CloudAdminSecretName).Secretvalue)

$CloudAdminCredential
```

[](images/Picture16.png)

7. Finally we can put it all together and make a connection to our PEP.

```
$PEPSession = New-PSSession -ComputerName $PrivilegedEndpoint -ConfigurationName PrivilegedEndpoint -Credential $CloudAdminCredential

Enter-PSSession $PEPSession
```

[](images/Picture17.png)

8. Once you have connected, run the following command to exit the PSSession.

```
Exit-PSSession
```