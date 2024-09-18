# Connect to Azure Stack Hub Privileged Endpoint

As an Azure Stack Hub operator, you should use the administrator portal, PowerShell, or Azure Resource Manager APIs for most day-to-day management tasks. However, for some less common operations, you need to use the privileged endpoint (PEP). The PEP is a pre-configured remote PowerShell console that provides you with just enough capabilities to help you do a required task. The endpoint uses PowerShell JEA (Just Enough Administration) to expose only a restricted set of cmdlets. To access the PEP and invoke the restricted set of cmdlets, a low-privileged account is used. No admin accounts are required. For additional security, scripting isn't allowed.

You can use the PEP to perform these tasks:

- Low-level tasks, such as collecting diagnostic logs.

- Many post-deployment datacenter integration tasks for integrated systems, such as adding Domain Name System (DNS) forwarders after deployment, setting up Microsoft Graph integration, Active Directory Federation Services (AD FS) integration, certificate rotation, and so on.

- To work with support to obtain temporary, high-level access for in-depth troubleshooting of an integrated system.

The PEP logs every action (and its corresponding output) that you perform in the PowerShell session. This provides full transparency and complete auditing of operations. You can keep these log files for future audits.

## Access the privileged endpoint

You access the PEP through a remote PowerShell session on the virtual machine (VM) that hosts the PEP. In the ASDK, this VM is named **AzS-ERCS01**. If you're using an integrated system, there are three instances of the PEP, each running inside a VM (Prefix-ERCS01, Prefix-ERCS02, or Prefix-ERCS03) on different hosts for resiliency.

Before you begin this procedure for an integrated system, make sure you can access the PEP either by IP address or through DNS. After the initial deployment of Azure Stack Hub, you can access the PEP only by IP address because DNS integration isn't set up yet. Your OEM hardware vendor will provide you with a JSON file named **AzureStackStampDeploymentInfo** that contains the PEP IP addresses.

You may also find the IP address in the Azure Stack Hub administrator portal. Open the portal, for example, **https://adminportal.local.azurestack.external**. Select **Region Management > Properties**.

NOTE: Because we have not completed datacenter integration you will need to login with the Cloud Admin credentials.
 Username: [CloudAdmin@AzureStack.local](mailto:CloudAdmin@AzureStack.local) & use the lab password.

You will need set your current culture setting to en-US when running the privileged endpoint, otherwise cmdlets such as Test-AzureStack or Get-AzureStackLog will not work as expected.

1. Establish the trust.
   
- On an integrated system, run the following command from an elevated Windows PowerShell session to add the PEP as a trusted host on the hardened VM running on the hardware lifecycle host or the Privileged Access Workstation.
  ## NOTE You will get an Error running this as your ASDK is configured to trust all hosts using (*)

```
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '<IP Address of Privileged Endpoint>' -Concatenate
```

2. On the hardened VM running on the hardware lifecycle host or the Privileged Access Workstation, open a Windows PowerShell session. Run the following commands to establish a remote session on the VM that hosts the PEP:

```
$Credentials = Get-Credential
```

NOTE: When prompted for a credential use [CloudAdmin@AzureStack.local](mailto:CloudAdmin@AzureStack.local) and the lab password.

```
$PEPSession = New-PSSession -ComputerName <IP_address_of_ERCS> -ConfigurationName PrivilegedEndpoint -Credential $Credentials -SessionOption (New-PSSessionOption -Culture en-US -UICulture en-US)
```

3. Now that you have a PowerShell Session connected to the PEP, you can run commands directly on the PEP by using: **Enter-PSSession $PEPSession**

4. Run Get-Command to review the list of PowerShell commands available.

```
Get-Command
```

5. Exit the PSSession

```
Exit-PSSession
```

6. JEA restrictions will prevent you from running any commands except for a specific list.
If you have the need to work with the data returned from the command for automation or export, you can remotely run commands through the session by using Invoke-Command.

```
Invoke-Command -Session $PEPSession -ScriptBlock {Command or script}
```
