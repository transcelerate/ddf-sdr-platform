
- [Introduction](#introduction)
  - [Requirements to Contribute and Propose Changes](#requirements-to-contribute-and-propose-changes)
- [Intended Audience](#intended-audience)
- [Overview](#overview)
  - [Modules](#modules)
    - [main.tf](#maintf)
    - [Variables.tf](#variablestf)
- [Deployment Process](#deployment-process)
  - [Pre-Requisites](#pre-requisites)
  - [Secrets](#secrets)
    - [main.yml Secret Variables](#mainyml-secret-variables)
    - [Variables.tf Secret Variables](#variablestf-secret-variables)
  - [Deployment Actions](#deployment-actions)
    - [main.yml](#mainyml)
- [Infrastructure Changes for Release V3.0 (May 2024)](#infrastructure-changes-for-release-v30-may-2024)
- [Support](#support)

# Introduction

Study Definition Repository (SDR) Reference Implementation is TransCelerate’s vision to catalyze industry-level transformation, enabling digital exchange of study definition information by collaborating with technology providers and standards bodies to create a sustainable open-source Study Definition Repository.

The below documents provide a high level overview of the SDR Reference Implementation.
- [DDF SDR RI Solution Architecture Document](documents/sdr-release-v3.0/ddf-sdr-ri-solution-architecture-v6.0.pdf)
- [DDF SDR RI High Level Design](documents/sdr-release-v3.0/ddf-sdr-ri-process-flows-v4.0.pdf)
- [DDF SDR RI Process Flows Document](documents/sdr-release-v2.0.2/ddf-sdr-ri-process-flows-v4.0.pdf)

**NOTES:** 
- These materials and information are provided by TransCelerate Biopharma Inc. AS IS.  Any party using or relying on this information and these materials do so entirely at their own risk.  Neither TransCelerate nor its members will bear any responsibility or liability for any harm, including indirect or consequential harm, that a user may incur from use or misuse of this information or materials.
- Please be advised that if you implement the code as written, the functionality is designed to collect and store certain personal data (user credentials, email address, IP address) for authentication and audit log purposes. None of this information will be shared with TransCelerate or Accenture for any purpose. Neither TransCelerate nor Accenture bears any responsibility for any collection, use or misuse of personal data that occurs from any implementation of this source code. If you or your organization employ any of the features that collect personal data, you are responsible for compliance with any relevant privacy laws or regulations in any applicable jurisdiction.
- Please be aware that any information you put into the provided tools (including the UI or API) will be visible to all users, so we recommend not using commercially sensitive or confidential information.  You and/or your employer bear all responsibility for anything you share with this project.  TransCelerate, its member companies and any vendors affiliated with the DDF project are not responsible for any harm or loss you occur as a result of uploading any information or code: commercially sensitive, confidential or otherwise. 
- To the extent that the SDR Reference Implementation incorporates or relies on any specific branded products or services, such as Azure, this resulted out of the practical necessities associated with making a reference implementation available to demonstrate the SDR’s capabilities.  Users are free to download the source code for the SDR from GitHub and design their own implementations.  Those implementations can be in an environment of the user’s choice, and do not have to be on Azure. 
- As of May 2024, the DDF initiative is still the process of setting up operations, and any pull requests submitted will not be triaged at this point in time. 

## Requirements to Contribute and Propose Changes
Before participating, you must acknowledge the Contribution License Agreement (CLA).

To acknowledge the CLA, follow these instructions:

- Click [here](https://github.com/transcelerate/ddf-home/blob/main/documents/DDF_CLA_2022MAR28_FINAL.pdf) to download and carefully read the CLA.
- Print the document.
- Complete and sign the document.
- Scan and email a PDF version of the completed and signed document to [DDF@transceleratebiopharmainc.com](mailto:DDF@transceleratebiopharmainc.com?subject=Signed%20CLA).

NOTE: Keep a copy for your records.

# Intended Audience

The contents in this repository allows users to deploy SDR Reference Implementation Infrastructure onto their Azure Cloud Subscription via their own GitHub Repos and Workflows. The deployment scripts (YAML Scripts) can be configured and executed from GitHub Actions, leveraging GitHub Secrets to configure target environment specific values.

It assumes a good understanding of Azure concepts and services. The audience for this document should:
- have basic understanding of Terraform
- be aware of how to use Azure portal and basic understanding of Azure Cloud Platform
- have basic understanding of GitHub Actions, Secrets & Yaml Scripts


# Overview

 This repository contains Terraform IaC code and configuration for deploying SDR Infrastructure resources to Azure Cloud Platform.

- modules - Contains code for all the resources which can be reusable. 
- main.tf - Contains modules for all the resources which can be reusable.
- variables.tf - Contains the variables for all the modules/resources.

## Modules

This folder contains all the modularized code for the resources listed below.

|               Configuration Container                | Diagnostic Settings Container |                                     Description                                     |
|:----------------------------------------------------:|:-----------------------------:|:-----------------------------------------------------------------------------------:|
|                    resourcegroup                     |                               |                        Code for creating **Resource Group**                         |
|                    api_management                    |  api_management_diagsettings  |   Code for creating **API Management** instance and enabling diagnostic settings    |
|                     app_service                      |   app_service_diagsettings    |     Code for creating **App Service** instance and enabling diagnostic settings     |
|                   app_service_plan                   | app_service_plan_diagsettings |       Code for creating **App Service Plan** and enabling diagnostic settings       |
|                      cosmos_db                       |     cosmosdb_diagsettings     |       Code for creating **Azure Cosmos DB** and enabling diagnostic settings        |
|               log_analytics_workspace                |    log_analy_diagsettings     |   Code for creating **Log Analytics Workspace** and enabling diagnostic settings    |
|           key_vault key_vault_accesspolicy           |     keyvault_diagsettings     |          Code for creating **Key Vault** and enabling diagnostic settings           |
|                         vnet                         |       vnet_diagsettings       |    Code for creating **Virtual Network (VNet)** and enabling diagnostic settings    |
|                        subnet                        |                               |                            Code for creating **Subnet**                             |
|                network_security_group                |                               |                  Code for creating **Network Security Group**                       |
|                subnet_nsg_association                |                               |         Code for associating **Subnet** and **Network Security Group**              |
|                      public_ip                       |                               |   Code for creating **Public IP** resource for associating with API Management      | 
|                   delegated_subnet                   |                               |                       Code for creating **Delegated Subnet**                        |
|                     app_insights                     |                               | Code for creating **Application Insights** resource for collecting Application logs |
| data_adgrouprole_assignments data_sprole_assignments |                               |       Code for reading **Azure AD Groups** and **Service Principal** for RBAC       |
|                   role_assignment                    |                               |           Code for granting access and RBAC role assignment to resources            |
| azuread_appregistration |             |  Code for creating **App Registration** to enable authentication for SDR Application
| azure_container_registry |            |  Code for creating **Azure Container Registry** 
| function_app  |     functionapp_diagsettings                  |  Code for creating **Azure Function App** and enabling diagnostic settings
| service_bus   |                       |  Code for creating **Azure Service Bus**

## main.tf

- This file contains the resource configuration code. This file invokes the modules for the specific resources to be deployed on the Azure Cloud Platform.
- Single module can be called multiple times to create the same set of resources with different naming conventions and configurations.

## Variables.tf

- Variables that are repeated / parameterized / environment specific, are declared in variables.tf.

# Deployment Process

**Important Note:** Refer to the [DDF SDR RI Platform Setup and Deployment Guide](documents/sdr-release-v3.0/ddf-sdr-ri-platform-setup-and-deployment-guide-v7.0.pdf) document for setting up a running instance of SDR on your own Azure Cloud Subscription. 

## Pre-Requisites

- Service principal in Azure AD with contributor access to Azure Subscription and user administrator access to Azure AD.
- Storage account and a blob container to store the Terraform state files.

## Secrets

- The secrets listed below must be created on Github. The secrets will be fetched and replaced in the main.yml and variables.tf files during the deployment action.

### main.yml Secret Variables

Terraform will use these secret values (from GitHub Secrets) to login to the Azure Cloud Platform and deploy the resources according to the configuration defined in the IaC code.

    - AZURE_SP              : The Service Principal details in JSON format.
    Service Principal Sample JSON :
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
    - AZURE_RESOURCEGROUP   : The name of the Resource Group that contains the storage account.
    - AZURE_STORAGEACCOUNT  : The Storage Account name
    - AZURE_CONTAINERNAME   : The name of the blob container wherein the Terraform State file will be stored.
    - AZURE_CLIENT_ID       : The Client Id of the service principal.
    - AZURE_CLIENT_SECRET   : The Client Secret value of the service principal.
    - AZURE_SUBSCRIPTION_ID : The Azure Subscription ID.
    - AZURE_TENANT_ID       : The Azure Tenant ID.
    - AZURE_RMKEY           : Terraform state file name for each environment. (Eg: xxxxdev.tfstate).

### Variables.tf Secret Variables

  These variables are environment-specific. Define IP address space for VNets and Subnets, Azure AD Groups and Service Principal for RBAC, and environment and subscription acronyms for resource naming conventions in the secrets section.

     - ENV               : Provide the name of the environment (for example, Dev or QA), which will be added to the resource naming convention.
     - VNET-IP           : Provide the VNet Address Space
     - SUBNET-IP         : Provide the Subnet Address Space
     - SUBNET_DSADDRESS1 : Provide the Delegated Subnet1 Address Space
     - SUBNET_DSADDRESS2 : Provide the Delegated Subnet2 Address Space
     - SUBNET_DSADDRESS3 : Provide the Delegated Subnet3 Address Space
     - SUBSCRIPTION      : Provide the short form of the subscription name; this will be added to the resource naming convention.
     - PUBLISHER_NAME    : Provide the publisher name for API Management Resource.
     - PUBLISHER_EMAIL   : Provide the publisher email id for API Management Resource.
     - ADGROUP1          : Provide the name of the Azure AD Group for contributor access to the App Resource Group (Admin Group).
     - ADGROUP2          : Provide the name of the Azure AD Group for contributor access to the App Resource Group (DevelopmentTeam_Group).
     - ADGROUP3          : Provide the name of the Azure AD Group for Reader access on App & Core Resource Groups.
     - SERVICEPRINCIPAL  : Provide the name of the Service principal that was created for the Git connection; it will provide key vault secret user access and access policies for secrets on Key Vault for the Service Principal.

## Deployment Actions

The folder .github/workflows contains the GitHub Actions yaml script (main.yml) for deploying the Terraform IaC code on Azure Cloud Platform. 

### main.yml

The yaml file is a multi-job script that will perform security checks on IaC code as well as the deployment of resources to the target environment on Azure Cloud Platform. Below tasks are in the main.yml file.

  **name: Terraform Install**
  - task will install the terraform and it's dependencies on hosted agents to deploy the resources
    - uses: hashicorp/setup-terraform@v1
    - with:
        - terraform_version: 0.14.11
         
  **name: Terraform Init**
  - initializes the terrafrom configuration files
    - run:  terraform init -backend-config="storage_account_name=$STORAGE_ACCOUNT"    -backend-config="container_name=$CONTAINER_NAME" -backend-config="resource_group_name=$RESOURCE_GROUP"  -backend-config="key=$Blob_Key" 
      
  **name: Terraform Plan**
  - task creates an execution plan which lets us to review the changes made to the environment before applying the changes
    - run: terraform plan
           
  **name: Terraform Apply**
  - task execute the actions proposed in the terraform plan
    - run: terraform apply -auto-approve

### Running GitHub Workflows
- **Step 1 :** Go to GitHub Actions and under the list of workflows click on CI.
- **Step 2 :** In this workflow click Run Workflow to trigger the Deployment Action.
- **Step 3 :** Once the workflow completes successfully, refer to the **[DDF SDR RI Platform Setup and Deployment Guide](documents/sdr-release-v3.0/ddf-sdr-ri-platform-setup-and-deployment-guide-v7.0.pdf)** for additional manual configuration updates to the deployed resources and further deploy SDR Reference Implementation (RI) Application Code.

**Important Note :** GitHub Actions does not allow multi-environment deployment setup with Free Pricing Plan. To Deploy to different environments, the GitHub secret values have to be updated with values of the target Azure Environment.

# Infrastructure Changes for Release V3.0 (May 2024)

- The steps required to migrate SDR infrastructure from Version 0.5 to Version 3.0 for users who have set up their own SDR instance for the Study Definition Repository – Reference Implementation on Azure Cloud Platform. It provides details for deploying the new resources using azure portal and migration of API Management resource to stv2 platform. Additionally, it provides details of containerized deployment for the SDR API and UI applications.

**Important Note:** Refer to the **[DDF SDR RI Infra Migration Guide (Release V3.0)](documents/sdr-release-v3.0/ddf-sdr-ri-infra-migration-guide-v1.0.pdf)** for upgrading to SDR Release V3.0.

# Support

- For any technical queries on SDR Platform repository, please create an issue [DDF SDR Support](https://github.com/transcelerate/ddf-sdr-support/issues/new?assignees=sdr-support&labels=techSupport&template=TechSupport.yml&title=%5BTechSupport%5D%3A).
