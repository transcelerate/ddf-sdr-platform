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

### Table 1: Group and Role Assignments
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
