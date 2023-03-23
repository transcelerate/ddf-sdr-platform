
- [Introduction](#introduction)
  - [Requirements to Contribute and Propose Changes](#requirements-to-contribute-and-propose-changes)
- [Intended Audience](#intended-audience)
- [Overview](#overview)
  - [Modules](#modules)
    - [main.tf](#maintf)
    - [Variables.tf](#variablestf)
- [Deployment Process](#deployment-process)
  - [Instructional Videos](#instructional-vidoes)
  - [Pre-Requisites](#pre-requisites)
  - [Secrets](#secrets)
    - [main.yml Secret Variables](#mainyml-secret-variables)
    - [Variables.tf Secret Variables](#variablestf-secret-variables)
  - [Deployment Actions](#deployment-actions)
    - [main.yml](#mainyml)
- [Infrastructure Changes for Release V2.0](#infrastructure-changes-for-release-v20)
  - [Deployment Process for Release V2.0](#deployment-process-for-release-v20)
    - [Steps to Migrate](#steps-to-migrate)
    - [Containerized Deployment](#containerized-deployment)

# Introduction

Study Definition Repository (SDR) Reference Implementation is TransCelerate’s vision to catalyze industry-level transformation, enabling digital exchange of study definition information by collaborating with technology providers and standards bodies to create a sustainable open-source Study Definition Repository.

**NOTES:** 
- These materials and information are provided by TransCelerate Biopharma Inc. AS IS.  Any party using or relying on this information and these materials do so entirely at their own risk.  Neither TransCelerate nor its members will bear any responsibility or liability for any harm, including indirect or consequential harm, that a user may incur from use or misuse of this information or materials.
- Please be aware that any information you put into the provided tools (including the UI or API) will be visible to all users, so we recommend not using commercially sensitive or confidential information.  You and/or your employer bear all responsibility for anything you share with this project.  TransCelerate, its member companies and any vendors affiliated with the DDF project are not responsible for any harm or loss you occur as a result of uploading any information or code: commercially sensitive, confidential or otherwise.  
- As of May 2022, the DDF initiative is still the process of setting up operations, and any pull requests submitted will not be triaged at this point in time.

## Requirements to Contribute and Propose Changes
Before participating, you must acknowledge the Contribution License Agreement (CLA).

To acknowledge the CLA, follow these instructions:

- Click [here](https://github.com/transcelerate/ddf-home/blob/main/documents/DDF_CLA_2022MAR28_FINAL.pdf) to download and carefully read the CLA.
- Print the document.
- Complete and sign the document.
- Scan and email a PDF version of the completed and signed document to [DDF@transceleratebiopharmainc.com](mailto:DDF@transceleratebiopharmainc.com?subject=Signed%20CLA).

NOTE: Keep a copy for your records.

# Intended Audience

The content in this repository assumes a good understanding of Azure concepts and services. The audience for this document is:

- User should have basic understanding of Terraform
- User should be aware of how to use Azure portal and basic understanding of Microsoft Azure Platform
- User should have basic understanding of GitHub Actions & Yaml

There are documents to provide a high level overview of the SDR Reference Implementation.
- [Azure Solution Architecture Document](documents/ddf-sdr-azure-solution-architecture-v2.0.pdf)
- [Process Flows Document](documents/ddf-sdr-process-flows-v3.0.pdf)

# Overview

 This repository contains Terraform IaC code and configuration for Deploying SDR Infrastructure resources to Microsoft Azure Platform.

 Terraform : Terraform is an infrastructure-as-code tool that greatly reduces the amount of time needed to implement and scale the infrastructure. It is provider agnostic.

 The folder structure of the IaC code is shown below.

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
|                   delegated_subnet                   |                               |                       Code for creating **Delegated Subnet**                        |
|                     app_insights                     |                               | Code for creating **Application Insights** resource for collecting Application logs |
| data_adgrouprole_assignments data_sprole_assignments |                               |       Code for reading **Azure AD Groups** and **Service Principal** for RBAC       |
|                   role_assignment                    |                               |           Code for granting access and RBAC role assignment to resources            |
| azuread_appregistration |             |  Code for creating **App Registration** to enable authentication for SDR Application
| azure_container_registry |            |  Code for creating **Azure Container Registry** 
| function_app  |                       |  Code for creating **Azure Function App**
| service_bus   |                       |  Code for creating **Azure Service Bus**

## main.tf

- This file contains the resource configuration code. This file invokes the modules for the specific resources to be deployed on the Microsoft Azure Platform.
- Single module can be called multiple times to create the same set of resources with different naming conventions and configurations.

## Variables.tf

- Variables that are repeated / parameterized / environment specific, can be declared in variables.tf.

# Deployment Process

**Important Note:** Refer to the **[DDF SDR Azure Platform Setup and Deployment Guide](documents/ddf-sdr-azure-platform-setup-and-deployment-guide-v3.0.pdf)** and **[DDF SDR Azure Platform Design and Implementation Guide](documents/ddf-sdr-azure-platform-design-and-implementation-v2.0.pdf)** documents before following the below steps. 

## Instructional Vidoes

Several videos have been created to show steps a user would need to go through to provision a new instance of the SDR in their organization's local Azure environment.
1. [Environment Creation for SDR on Azure](https://www.youtube.com/watch?v=z_W-sOW7Kdk)
2. [Deploying SDR code on Azure DevOps](https://www.youtube.com/watch?v=nsYb33Jq6Qo&list=PLMXS-Xt7Ou1KNUF-HQKQRRzqfPQEXWb1u&index=2)
3. [Azure PaaS Configurations](https://www.youtube.com/watch?v=koYWS-DikIY)
4. [Application Data Setup and Smoke Test](https://www.youtube.com/watch?v=q0eg_Xji9RQ)
5. [SonarQube Integration with Azure](https://www.youtube.com/watch?v=WF42UIxhSd0&list=PLMXS-Xt7Ou1KNUF-HQKQRRzqfPQEXWb1u&index=5)

## Pre-Requisites

- Service principal in Azure AD with contributor access to Azure Subscription and user administrator access to Azure AD.
- Storage account and a blob container to store the Terraform state files.

## Secrets

- The secrets listed below must be created on Github. The secrets will be fetched and replaced in the main.yml and variables.tf files during the deployment action.

### main.yml Secret Variables

Terraform will use these secret values (from GitHub Secrets) to login to the Microsoft Azure Platform and deploy the resources according to the configuration defined in the IaC code.

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

The folder .github/workflows contains the GitHub Actions yaml script (main.yml) for deploying the Terraform IaC code on Microsoft Azure Platform.
  **name: Terraform Install**
  - task will install the terraform and it's dependencies on microsoft hosted agents to deploy the resources
      uses: hashicorp/setup-terraform@v1
      with:
         terraform_version: 0.14.11
         
  **name: Terraform Init**
  - initializes the terrafrom configuration files
      run:  terraform init -backend-config="storage_account_name=$STORAGE_ACCOUNT" -backend-config="container_name=$CONTAINER_NAME" -backend-config="resource_group_name=$RESOURCE_GROUP"  -backend-config="key=$Blob_Key" 
      
  **name: Terraform Plan**
  - task creates an execution plan which lets us to review the changes made to the environment before applying the changes
      run: terraform plan
           
  **name: Terraform Apply**
  - task execute the actions proposed in the terraform plan
      run: terraform apply -auto-approve

### main.yml

The yaml file is a multi-job script that will perform security checks on IaC code as well as the deployment of resources to the target environment on Microsoft Azure Platform.

- **Step 1 :** Go to GitHub Actions and under the list of workflows click on CI
- **Step 2 :** In this workflow click Run Workflow to trigger the Deployment Action
- **Step 3 :** Once the workflow completes successfully, refer to the **[DDF SDR Azure Platform Setup and Deployment Guide](https://github.com/transcelerate/ddf-sdr-platform/raw/main/documents/ddf-sdr-azure-platform-setup-and-deployment-guide-v3.0.pdf)** for additional manual configuration updates to the deployed resources and further deploy SDR Reference Implementation (RI) Application Code

**Important Note :** GitHub Actions does not allow multi-environment deployment setup with Free Pricing Plan. To Deploy to different environments, the GitHub secret values have to be updated with values of the target Azure Environment.
# Infrastructure Changes for Release V2.0

- The steps required to migrate SDR infrastructure from Version 0.5 to Version 2.0 for users who have set up their own SDR instance for the Study Definition Repository – Reference Implementation on Azure Cloud Platform. It provides details for deploying the new resources using azure portal. Additionally, it provides details of containerized deployment for the SDR API and UI applications.

**Important Note:** Refer to the **[DDF SDR Infra Migration Guide (Release V2.0)](documents/DDF_SDR_Infra-Migration-guide (Release V2.0.pdf))** document before following the below steps. 

## Deployment Process for Release V2.0
## Steps to Migrate
**PRE-REQUISITES :**
- SDR Running instance on Azure (SDR Release V0.5).
- Minimum Contributor level of access at Subscription Level.
- Optionally, basic understanding of containerized deployments

   - **Step 1 :** Resources Configurations for Change Audit Feature
   - **Step 2 :**  Configuration for USDM Versioning
   - **Step 3 :**  Additional Cloud Configurations
   - **Step 4 :**  Build and Deployment Updates
## Containerized Deployment 
- The UI and API builds have been containerized as a part of SDR Release V2.0. The same has impacted the App Services on which the SDR Application is hosted. This section details the steps to enable containerized build and deployment. 
- This is an optional step. To continue with existing way of deployment of SDR use current App Service and Service Plan configuration and B&D scripts for UI and API for deployment as mentioned in section 3.4.2

  - **Step 1 :**  Recreate App Service Plans and App Services
  - **Step 2 :**  Create Azure Container Registry 
  - **Step 3 :**  GitHub Actions/YAML/Build & Deploy Script Updates