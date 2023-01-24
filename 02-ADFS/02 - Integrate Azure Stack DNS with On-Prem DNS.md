# Integrate Azure Stack DNS with On-Prem DNS
To be able to access Azure Stack Hub endpoints such as portal, adminportal, management, and adminmanagement from outside Azure Stack Hub, you need to integrate the Azure Stack Hub DNS services with the DNS servers that host the DNS zones you want to use in Azure Stack Hub.

***

## Resolving Azure Stack Hub DNS names from outside Azure Stack Hub

To integrate your Azure Stack Hub deployment with your DNS infrastructure, you need the following information:

- DNS server FQDNs
- DNS server IP addresses

The FQDNs for the Azure Stack Hub DNS servers have the following format:

- [NAMINGPREFIX]-ns01.[REGION].[EXTERNALDOMAINNAME]
- [NAMINGPREFIX]-ns02.[REGION].[EXTERNALDOMAINNAME]

When the deployment is completed, the technician will generally give you a file named AzureStackStampInformation.json.
This file contains several important pieces of information including the IP Addresses of the Privileged Endpoints, Domain Names, Endpoint URLs and also the DNS Server information required for this step.
If you do not have this information, you can usually find a copy on your HLH or ASDK machine in C:\CloudDeployment\Logs

1.	Open the AzureStackStampInformation.json and locate the information above.

/images/image.png


