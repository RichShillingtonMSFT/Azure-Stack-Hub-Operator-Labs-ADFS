# Running Test-AzureStack

As an Azure Stack Operator, you will become very familiar with the command Test-AzureStack. It is suggested that you run this command at least once per week. The command also has some switches that are to be run prior to performing tasks like applying updates or rotating secrets.

## Run Test-AzureStack

The Test-AzureStack command will give you insights into the health and any issues with the underlying Azure Stack Hub infrastructure. While errors will also appear in the Admin Portal, you can also automate the use of this command to check for issues and notify you should any be found.

For this lab, you will be connecting to the PEP. You can use the previous lab See LabFiles\01-Operator Workstation\02-Azure Stack Hub privileged endpoint\01 - Connect to Privileged Endpoint for reference.

1. Connect to the Privileged Endpoint using PowerShell remoting as AzureStack\CloudAdmin storing the connection in $PEPSession variable.


2. Using Invoke-Command, pass the following command in your script block:

```
Test-AzureStack -Debug
```

3. Review the output for any errors or warnings.

## Run Test-AzureStack before applying updates

**Prior to installing any updates on Azure Stack, you must run Test-AzureStack -Group UpdateReadiness on the PEP**. This will check the infrastructure for any errors that might cause an update to fail.

For this lab, you will be connecting to the PEP. You can use the previous lab See LabFiles\01-Operator Workstation\02-Azure Stack Hub privileged endpoint\01 - Connect to Privileged Endpoint for reference.

1. Connect to the PEP. You can use your existing PEP connection or create a new one.


2. Using Invoke-Command, pass the following command in your script block:

```
Test-AzureStack -Group UpdateReadiness
```

3. Review the output for any errors or warnings.

## Run Test-AzureStack before rotating secrets

**Prior to performing the secret rotation process on Azure Stack, you must run Test-AzureStack -Group SecretRotationReadiness on the PEP**. This will check the infrastructure for any errors that might cause a problem with secret rotation.

For this lab, you will be connecting to the PEP. You can use the previous lab See LabFiles\01-Operator Workstation\02-Azure Stack Hub privileged endpoint\01 - Connect to Privileged Endpoint for reference.

1. Connect to the PEP. You can use your existing PEP connection or create a new one.


2. Using Invoke-Command, pass the following command in your script block:

```
Test-AzureStack -Group SecretRotationReadiness
```

3. Review the output for any errors or warnings.