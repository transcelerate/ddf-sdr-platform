- [Introduction](#introduction)
- [Definitions and Acronyms](#definitions-and-acronyms)
- [Document Scope](#document-scope)
- [Out of Scope](#out-of-scope)
- [Audience](#audience)
- [Pre-Requisites](#pre-requisites)
- [Azure Infrastructure](#azure-infrastructure)
- [Resource Provider Registration](#resource-provider-registration)
- [Create Azure AD Groups](#create-azure-ad-groups)
- [Create Users](#create-users)
- [Role Based Access Controls (RBAC)](#role-based-access-controls-(rbac))
- [Storage Account and Service Principal Configuration in Azure](#storage-account-and-service-principal-configuration-in-azure)
- [Adding Secrets in GitHub](#adding-secrets-in-github)
- [Execute GitHub Action for IaC deployment](#execute-github-action-for-iac-deployment)
-[Manual Configuration Changes on Azure Platform](#manual-configuration-changes-on-azure-platform)
- [PaaS Setup – OAuth](#paas-setup--oauth )
- [Configuration for SDR UI Application](#configuration-for-sdr-ui-application)
- [UI App Path Mapping](#ui-app-path-mapping)
- [Key Vault](#key-vault)
- [Resource Validation](#resource-validation)
- [Low-Level Design Document](#low-level-design-document)
- [Virtual Network](#virtual-network)
- [Subnet](#subnet)
- [Delegated Subnet](#delegated-subnet)
- [Other Resources](#other-resources)
- [Application Code Deployment](#application-code-deployment)
- [GitHub Secrets used in WorkFlow](#github-secrets-used-in-workflow)
- [Deploy the UI Application](#)
- [Deploy Back-End API](#deploy-the-ui-application)
- [Deployment Verification](#deployment-verification)
- [PaaS Setup](#paas-setup)
- [PaaS Setup for APIM](#paas-setup-for-apim)
 
# Introduction
This document details the steps required to set up a new environment for the Study Definition Repository – Reference Implementation (MVP release) on Microsoft Azure Cloud Platform. It provides details for Infrastructure setup, environment validation, deploying the Web Application for User Interface and Application Programming Interface. 

This document is organized sequentially including Infrastructure, PaaS, UI and API components setup and is presented in a dependency-based order. All the sections listed here are mandatory for the environment setup.
## Definitions and Acronyms
|Term / Abbreviation	|Definition|
|-----|-----|
|AAD|	Azure Active Directory|
|AD|	Active Directory|
|API|	Application Programming Interface|
|Azure CLI	|Azure Command Line Interface|
|DB|	Database|
|DDF|	Digital Data Flow|
|HTTP|	Hypertext Transfer Protocol|
|IaC|	Infrastructure-as-Code|
|JSON|	JavaScript Object Notation|
|LLD|Low Level Design|
|MMC|	Microsoft Management Console|
|MS|	Microsoft|
|PaaS|	Platform-as-a-Service|
|RBAC|	Role Based Access Control|
|REST|	Representational State Transfer|
|SDR|	Study Definition Repository|
|UI|	User Interface|
|URL|	Uniform Resource Locator|
|VNet|	Virtual Network|

## Document Scope
 Scope of the document includes steps on how to create the Azure Active Directory Groups, Service Connections, Service Principals, and how to configure access using RBAC. This document also describes the process of application deployment for both UI and API along with PaaS Setup for hosting and integrating UI application (WebApp), Web API, APIM and CosmosDB. This also captures the Environment validation steps and Application Smoke testing.
## Out of Scope
 This document does not mention any details regarding setting up of a new Subscription as this assumes there is already an active subscription. This document also does not address application architecture patterns or designs.
## Audience
This document assumes a good understanding of Azure concepts and services. The audience for this document includes Azure Administrators, DevOps Engineers, Developers with experience in Angular and .NET development.
## Pre-Requisites
•	Access to the low-level design document and basic understanding on how to use it.<br> 
•	Access to the azure portal with required permissions (detailed in upcoming sections).<br> 
•	Azure CLI Refer to Install CLI<br> 
•	An Active Azure Tenant and Subscription. To setup Azure subscription please follow the below Microsoft Documentation<br> 
Create your initial Azure subscriptions - Cloud Adoption Framework | Microsoft Docs

# Azure Infrastructure
## Resource Provider Registration
### GOAL:
The Resource Provider Registration configures the Azure subscription to work with the resource provider.
### PRE-REQUISITES:
Global Admin or Subscription Owner level of access to Azure.
### STEPS:
i.	Sign into the Azure portal.<br> 
ii.	On the Azure portal menu<br> 
•	Search for Subscriptions.<br> 
•	Select it from the available options as shown below.

Figure 1 Select Subscriptions in Azure Portal

iii.	Select the subscription you want to view.

Figure 2 Select Subscription

iv.	On the left menu<br>
    Under Settings<br>
    select Resource providers.
    
Figure 3 Resource Providers in a Subscription
 
v.	Find the resource provider you want to register and select Register. To maintain least privileges in your subscription, only register the additional resource providers (other than default) that are required as listed below.<br>
The Providers to be registered are:<br>
•	Microsoft.Network<br>
•	Microsoft.OperationalInsights<br>
•	Microsoft.ApiManagement<br>
•	Microsoft.DocumentDB

Figure 4 Registering Resource Providers
 
## Create Azure AD Groups
### GOAL:
Create Azure AD groups to manage Role Based Access Controls (RBAC) on resources for team members.
### PRE-REQUISITES:
•	Global administrator/Owner/User Administrator level of access at Active Directory Level.<br> 
Below are the groups and role assignments created and managed for SDR Reference Implementation.

#### Table 1: Group and Role Assignments
|RBAC Group Name| 	Azure Built-In Role| 	Scope| 	Usage|
|-----|-----|-----|-----|
|GlobalAdmin_Group|	Global Administrator|	Azure Active Directory|	Can manage all aspects of Azure AD and Microsoft services that use Azure AD identities.| 
|Contributor_Group|	Contributor|	Subscription|	Grants full access to manage all resources but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, share image galleries, or perform Azure Policy operations.| 
|Owner_Subscription_Group|	Owner	|Subscription|	Grants full access to manage all resources, including the ability to assign roles in Azure RBAC.|
|Infra_Group|	Contributor|	Subscription|	Grants full access to manage all resources but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, share image galleries, or perform Azure Policy operations.|
|X|	Global Reader|	Azure Active Directory|	Can be able to read all users and groups information in Azure AD.|
|X|	User Administrator|	Azure Active Directory|	Can manage all aspects of users and groups, including resetting passwords for limited admins.|
|X|User Access Administrator|	Subscription|	Let's you manage user access to Azure resources. |
DevelopmentTeam_Group	|Reader|	Subscription|	Grants Reader access for all the resources in the Subscription but does not allow you to manage them.|
|X|	Contributor|	Resource Group	|Grants full access to manage all resources in the Resource Group.|
|TestingTeam_Group|	Reader|	Resource Group|	Grants Reader access for all the resources in the Subscription but does not allow you to manage them.|
|AppRegistration_Group	|Application administrator|	Azure Active Directory|	Can create and manage all aspects of app registrations and enterprise apps.|

```
Note: To assign Azure AD roles to groups required Azure AD Premium P1 or P2 license, since this solution is part of MVP leveraged Azure AD Free plan. Follow the Microsoft Doc to assign Azure AD role to groups.
```
### STEPS:
i.	Login to Azure portal<br>
ii.	Search for Azure Active Directory<br>
iii.	Click on the Groups on the left panel in AAD.<br>
iv.	Click on New group tab on the top as shown below, add the security group and save the changes by adding the members to the group.

Figure 5 Adding new groups
 

Figure 6 Add New Group
 
## Create Users
### GOAL:
 Create users for provisioning access to the resources on Azure Portal.
### PRE-REQUISITES: 
• Global administrator/User Administrator level of access at Active Directory Level.
### STEPS: 
i.	Login to Azure portal<br>
ii.	Search for Azure Active Directory (AAD)<br>
iii.	Click on the users on the left panel in AAD.<br>
iv.	Click on New User tab on the top, add the user and save the changes.

Figure 7 Create New User
 
## Role Based Access Controls (RBAC)
### GOAL:
 Providing access and assigning roles to Azure AD groups for them to access the resources.
### PRE-REQUISITES: 
• Contributor and User Administrator level of access at Subscription and Active Directory Level respectively. 
### STEPS:
Access Control (IAM) is to limit access and assign roles to groups at the subscription, resource group, and resource level. 
At subscription level<br>
i.	Go to the subscription.<br>
ii.	On the left pane select Access control (IAM) as shown in below screenshot.

Figure 8 Access Control (IAM)
 
iii.	Click on + Add and add the role assignment

Figure 9 Add Role Assignment
 
iv.	Select the required role (ex: reader, contributor etc., Refer Table 1) for the members and assign the role to the created groups as shown in the screenshot below and save the changes.

Figure 10 Select Roles
 
Figure 11 Select Members for Role Assignment
 
v.	To view the roles assigned to a particular group navigate to Role assignments tabs as shown below:

Figure 12 View Role Assignments
 
The same procedure should be followed to provide access/assign roles to any resource in the Azure portal.

## Storage Account and Service Principal Configuration in Azure
### GOAL:
Setup storage account and service principal in Azure to enable deployment from GitHub.
### PRE-REQUISITES:
•	Contributor level of access at Active Directory Level. 
#### STORING THE TERRAFORM STATE FILE REMOTELY:
When deploying resources with Terraform, a state file must be stored; this file is used by Terraform to map Azure Resources to the configuration that you want to deploy, keeps track of meta data, and can also help with improving performance for larger Azure Resource deployments.<br>
i.	Create Storage Account and Blob Container for storing State file remotely.<br>
ii.	Perform the below commands on Azure CLI for storage Account creation.

#### Table 2: Azure CLI Code Snippet - Create Storage Account
```
# Create Resource Group
az group create -n ResourceGroupName -l eastus2

# Create Storage Account
az storage account create -n StorageAccountName -g ResourceGroupName -l eastus2 --sku Standard_LRS

 # Create Storage Account Container
az storage container create -n StorageBlobContainerName --account-name StorageAccountName --auth-mode login
```
# AZURE SERVICE PRINCIPAL:
Create a service principal that will be used by Terraform to authenticate to Azure and assign role to this newly created service principal (RBAC) to the required subscription.<br>
i.	Perform the below command on Azure CLI and capture the JSON output and create an AZURE_SP secret on GitHub and provide the captured output as value for the secret.<br>
ii.	Provide User Administrator access on Azure AD and User Access administrator access on Azure Subscription.

#### Table 3: Azure CLI Code Snippet - Create Azure Service Principal
```
# Create Service Principal 

az ad sp create-for-rbac --name "ServicePrincipal" --role contributor --scopes /subscriptions/[enter subscription id] --sdk-auth

Service Principal Sample JSON output:
{
"clientId": "***Client-Id***",
"clientSecret": "***Client-Secret***",
"subscriptionId": "***SusbscriptionId***",
"tenantId": "***TenantID***",
"activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
"resourceManagerEndpointUrl": "https://management.azure.com/",
"activeDirectoryGraphResourceId": "https://graph.windows.net/",
"sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
"galleryEndpointUrl": "https://gallery.azure.com/",
"managementEndpointUrl": "https://management.core.windows.net/"
}
```
## Adding Secrets in GitHub
### GOAL:
Configure secrets in GitHub used by GitHub Actions during deployment workflow execution.
### PRE-REQUISITES:
•	Repo Admin level of access on GitHub Repository<br>
•	Capture below secret values based on environment design decisions and storage account, service principal details from Section (Storage Account and Service Principal Configuration in Azure)

#### Table 4 GitHub Secrets
|Secret Name|	Values|
|-----|-----|
|AZURE_SP	|The Service Principal details in JSON format.|
|AZURE_RESOURCEGROUP	|The name of the Resource Group that contains the storage account.|
|AZURE_STORAGEACCOUNT|	The Storage Account name|
|AZURE_CONTAINERNAME|	The name of the blob container wherein the Terraform State file will be stored.|
|AZURE_CLIENT_ID	|The Client Id of the service principal.|
|AZURE_CLIENT_SECRET	|The Client Secret value of the service principal.|
|AZURE_SUBSCRIPTION_ID	|The Azure Subscription ID|
|AZURE_TENANT_ID|	The Azure Tenant ID|
|AZURE_RMKEY|	Terraform state file name for each environment. (Eg: xxxxdev.tfstate).|
|Env	|Provide the name of the environment (for example, Dev or QA), which will be added to the resource naming convention.|
|VNet-IP|	Provide the VNet Address Space|
|Subnet-IP|	Provide the Subnet Address Space|
|Subnet-Dsaddress1|	Provide the Delegated Subnet1 Address Space|
|Subnet-Dsaddress2	|Provide the Delegated Subnet2 Address Space|
|subscription|	Provide the short form of the subscription name; this will be added to the resource naming convention.|
|Publisher-Name|	Provide the Publisher name for API Management Resource.|
|Publisher-Email|	Provide the publisher email id for API Management Resource.|
|ADgroup1|	Provide the name of the Azure AD Group for contributor access to the App Resource Group (Admin Group).|
|ADgroup2|	Provide the name of the Azure AD Group for contributor access to the App Resource Group (DevelopmentTeam_Group).|
|ADgroup3|	Provide the name of the Azure AD Group for Reader access on App & Core Resource Groups.|
|Serviceprincipal|Provide the name of the Service principal that was created for the Git connection;it will provide key vault secret user access and access policies for secrets on Key Vault for the Service Principal.|

### STEPS:
Add GitHub Secrets entries for all the secrets captured in the pre-requisites.<br>
i.	Go to repository settings.<br>
ii.	On the lower left-hand side of the screen, click on Secrets.<br>
iii.	Under that click on Actions.<br>
iv.	Then click on New Repository Secret.

Figure 13 GitHub Actions Secrets
 
v.	After clicking New Repository Secret, fill the details of the secret (name and value) in the boxes
 
Figure 14 Add new GitHub Action Secret
 
## Execute GitHub Action for IaC deployment 
### GOAL:
Execute the GitHub actions to deploy the Azure resources using IaC code.
### PRE-REQUISITES:
•	Repo Admin level of access on GitHub Repository<br>
•	For setting up the actions in GitHub, user must have Write permission on repos
### DEPLOYMENT:
The folder `.github/workflows` in the IaC Repository on GitHub contains the GitHub Actions yaml script (main.yml) for deploying the Terraform IaC code on Microsoft Azure Platform.

### main.yml:

The yaml file is a multi-job script that will perform security checks on IaC code as well as the deployment of resources to the target environment on Microsoft Azure Platform.

### STEPS:
i.	Go to GitHub Actions and under the list of workflows click on CI.<br>
ii.	In this workflow click Run Workflow to trigger the Deployment Action.<br>
iii.	Once the workflow completes successfully, the SDR Solution resources should have been deployed to Azure platform.

