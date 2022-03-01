# SDR Infrastructure IAC

# Authors

    Name    : Mani Chaitanya
    Version : 1.0
    Date    : 12/14/2021


# Intended Audience:

This document assumes a good understanding of Azure concepts and services. The audience for this document is: 

    - User should have basic understanding of Terraform
    - User should be aware of how to use Azure portal and basic understanding of Azure Platform
    - User should have basic understanding of Azure DevOps & Yaml piplelines

# Overview:

 Here you can find the Terraform IAC code and cofiguration for Deploying SDR Infrastructure resources.

 Terraform : Terraform is an infrastructure-as-code tool that greatly reduces the amount of time needed to implement and scale the infrastructure. It's provider agnostic so it works great for our use case.

 In our SDR IAC, we have the following folder structure.

    docs         -    Contains the SDR Architechture Diagram and Branch Merge flow diagram.
    modules      -    Contains code for all the resources which can be reusable.
    pipelines    -    Conatins yaml pipeline code.  
    main.tf      -    Contains modules for all the resources which can be reusable.
    variables.tf -    Conatins the variables for all the modules/resources.

# References
 
    - Low-Level Design document

    https://ts.accenture.com/:x:/r/sites/DigitalDataFlow-ACNOnly/Shared%20Documents/ACN%20Only/Azure_Platform_Infra/2_Design/Transcelerate%20-%20Low%20Level%20Design%20Document_Iteration2.xlsx?d=w13bf2fbdc42f45a784c2f8575d20b545&csf=1&web=1&e=me7ZSB
    
    - Setting up a new environment (end-end) document

    https://ts.accenture.com/:w:/r/sites/DigitalDataFlow-ACNOnly/Shared%20Documents/ACN%20Only/Azure_Platform_Infra/1_Plan-Analyze/WhiteBoards/SETTING%20UP%20SDR%20AZURE%20PLATFORM%20IN%20A%20NEW%20SUBSCRIPTION%20-%20DRAFT%20V2.0.docx?d=wd3a70669536f40c4a4f4d401386afa67&csf=1&web=1&e=laKZ8s

# Pre-Requisites

   - Create a Service principle in Azure Ad and grant contributor access on Azure Subscription and user administrator access on Azure AD.
   - Create a storage account and a blob container to store the Terraform state files.
   - Create Secrets variable groups to be passed to the main.yml and variables.tf files.

# Secrets

   - The secrets listed below must be created on Azure Devops/Github. The secrets will be fetched by the main.yml and variables.tf files while runnig the pipeline.

   - Create separate secret variable groups for each environment (Dev & QA) and link these variable groups to specific environment stages in main.yml.

### main.yml Secret Variables

   Terraform will use these secret values to login to the Azure Platform and deploy the resources according to the configuration defined in the IAC code.

    - AZURE_SP              : Provide the service principle details on this secret value in .json format. 
                              (az ad sp create-for-rbac --name "ServicePrincipal" --role contributor --scopes /subscriptions/[enter your subscription id] --sdk-auth)
                              By running this code in the Azure portal command line to create a service principal, scoped to a particular Subscription. This will generate a .Json code, copy and paste it on AZURE_SP secret.
    - AZURE_RESOURCEGROUP   : Provide the name of the Resource Group that contains the storage account.
    - AZURE_STORAGEACCOUNT  : Provide the Storage Account name
    - AZURE_CONTAINERNAME   : Provide the name of the blob container where the Terraform State file will be stored.
    - AZURE_CLIENT_ID       : Provide the Client Id of the service principle.
    - AZURE_CLIENT_SECRET   : Provide the Client Secret value of the service principle.
    - AZURE_SUBSCRIPTION_ID : Provide the Azure Subscription ID.
    - AZURE_TENANT_ID       : Provide the Azure Tenant ID.
    - AZURE_RMKEY           : Provide a meaningful terraform state file name for each environment. (Eg: xxxxdev.tfstate).

### Variables.tf Secret Variables

   This variables are environment (Eg: Dev & QA) specific. Here we define IP address space for Vnet and subnets, AD Groups & Service principle for RBAC,environment & subscription acronyms for resource naming convention.

     - Env               : Provide the name of the environment (for example, Dev or QA), which will be added to the resource naming convention.
     - Vnet-IP           : Provide the Vnet Address Space
     - Subnet-IP         : Provide the Subnet Address Space
     - Subnet-Dsaddress1 : Provide the Deligated Subnet1 Address Space
     - Subnet-Dsaddress2 : Provide the Deligated Subnet2 Address Space
     - subscription      : Provide the short form of the subscription name; this will be added to the resource naming convention.
     - Publisher-Email   : Provide the publisher email id for API Management Resource.
     - ADgroup1          : Provide the name of the AD Group for contributor access to the APP Resource Group (Admin Group).
     - ADgroup2          : Provide the name of the AD Group for contributor access to the APP Resource Group (DevelopmentTeam_Group).
     - ADgroup3          : Provide the name of the AD Group for Reader access on APP & Core Resource Groups.
     - ServicePrinciple  : Provide the name of the Service Principle that was created for the Azure Devops/Git connection; it will provide key vault secret user access and access policies for secrets on Key Vault for the spn.

# Pipelines:

   This folder contains the GitHub Actions yaml pipeline code (main_pipeline.yml) and steps (steps.yml) for deploying the Terraform IAC code on Azure Platform.
   
   ### main.yml:

   - The pipeline is a multi-stage pipeline that will perform security checks on IAC code as well as the deployment of each environment QA and Dev.
       
   - The tasks and stages for deploying IAC code via GitHub are contained in this Yml file. The tasks and stages we used in SDR are listed below.

   ## Stages

   ### Checkov_Validation

   This stage will run linting and security checks on the IAC code and output the results to the JUnitsectests.xml file.
 
   ##### stages contains a multiple jobs and tasks for deploying IAC code.

   #### Jobs

    - Terraform_Plan  : This Job creates an execution plan which lets us to review the changes made to the environment before applying the changes.
    - Manual_Approval : This job is responsible for reviewing the Terraform execution plan and manual approval prior to deployment on the Azure Portal.
    - Terraform_Apply : This Job will deploy the resources on Azure Portal.

   #### Tasks:

    - Install Python       : This task will install required python packages for checkov.
    - Publish Test Results : This task will publish the IAC code security check results.
    - Replace Tokens       : This task will replace the variables on variables.tf & main_pipeline.yml files with secret values.
    - Terraform Install    : This task will install the terraform and it's dependencies on microsoft hosted agents to deploy the resources.
    - Terraform Init       : This task initializes the terrafrom configuration files. this is the first command that should be run after writing a new terrafrom configuration or cloning an existing file.
    - Terraform Validate   : This task validates the terraform configuration files and displays the errors if any (eg: IAC code syntax errors)
    - Terraform Plan       : This task creates an execution plan which lets us to review the changes made to the environment before applying the changes.
    - Terraform Apply      : This task execute the actions proposed in the terraform plan. It apply the changes and deploys the code to the azure platform.
   
# Docs 

    The docs folder consists of SDR Architechture Diagram and supporting documents.

# Modules:

    This folder contains all the modular code for the below resources.

   ## Resource Group:
   
   This module contains the code for creating resource group on azure portal. This folder contains rg.tf, variables.tf & output.tf files.
   
    - rg.tf         :  It contains the terraform code for resource group creation.
    - variables.tf  :  It contains all the variables declared in the resource group (rg.tf).
    - output.tf     :  It contains the output variables called from rg.tf file and can be accessed by other modules in main.tf using data source.

   ## Vnet:

   This module contains the code for creating Vnet on azure portal. This folder contains vnet.tf, variables.tf & output.tf files.
   
    - vnet.tf         :  It contains the terraform code for vnet creation. Any new configurations/settings in this tf file. 
    - variables.tf    :  It contains all the variables declared in the vnet (vnet.tf).
    - output.tf       :  It contains the output variables called from vnet.tf file and can be accessed by other modules in main.tf using data source.

   ## Subnet:

   This module contains the code for creating Subnet on azure portal. This folder contains subnet.tf, variables.tf & output.tf files.
   
    - subnet.tf       :  It contains the terraform code for Subnet creation. Any new configurations/settings in this tf file. 
    - variables.tf    :  It contains all the variables declared in the Subnet (subnet.tf).
    - output.tf       :  It contains the output variables called from subnet.tf file and can be accessed by other modules in main.tf using data source.

   ## Delegated Subnet:

   This module contains the code for creating Delegated Subnet on azure portal. This folder contains delegated_subnet.tf, variables.tf & output.tf files.
   
    - delegated_subnet.tf   :  It contains the terraform code for Delegated Subnet creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the Delegated Subnet (delegated_subnet.tf).
    - output.tf             :  It contains the output variables called from delegated_subnet.tf file and can be accessed by other modules in main.tf using data source.

   ## Key Vault:

   This module contains the code for creating Key Vault on azure portal. This folder contains key_vault.tf, variables.tf & output.tf files.
   
    - key_vault.tf          :  It contains the terraform code for Key Vault creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the Key Vault (key_vault.tf).
    - output.tf             :  It contains the output variables called from key_vault.tf file and can be accessed by other modules in main.tf using data source.

   ## Log Analytics Workspace:

   This module contains the code for creating Log Analytics Workspace on azure portal. This folder contains log_analytics.tf, variables.tf & output.tf files.
   
    - log_analytics.tf      :  It contains the terraform code for Log Analytics Workspace creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the Log Analytics Workspace (log_analytics.tf).
    - output.tf             :  It contains the output variables called from log_analytics.tf file and can be accessed by other modules in main.tf using data source.

   ## Application Insights:

   This module contains the code for creating Application Insights on azure portal. This folder contains app_insights.tf, variables.tf & output.tf files.
   
    - app_insights.tf       :  It contains the terraform code for Application Insights creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the Application Insights (app_insights.tf).
    - output.tf             :  It contains the output variables called from app_insights.tf file and can be accessed by other modules in main.tf using data source.

   ## App Service Plan:

   This module contains the code for creating App Service Plan on azure portal. This folder contains appserviceplan.tf, variables.tf & output.tf files.
   
    - appserviceplan.tf     :  It contains the terraform code for App Service Plan creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the App Service Plan (appserviceplan.tf).
    - output.tf             :  It contains the output variables called from appserviceplan.tf file and can be accessed by other modules in main.tf using data source.

   ## App Service:

   This module contains the code for creating App Service on azure portal. This folder contains appservice.tf, variables.tf & output.tf files.
   
    - appservice.tf         :  It contains the terraform code for App Service creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the App Service (appservice.tf).
    - output.tf             :  It contains the output variables called from appservice.tf file and can be accessed by other modules in main.tf using data source.

   ## API Management:

   This module contains the code for creating API Management on azure portal. This folder contains apimanagement.tf, variables.tf & output.tf files.
   
    - apimanagement.tf      :  It contains the terraform code for API Management creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the API Management (apimanagement.tf).
    - output.tf             :  It contains the output variables called from apimanagement.tf file and can be accessed by other modules in main.tf using data source.

   ## Cosmos DB:

   This module contains the code for creating Cosmos DB on azure portal. This folder contains cosmos.tf, variables.tf & output.tf files.
   
    - cosmos.tf             :  It contains the terraform code for Cosmos DB creation. Any new configurations/settings in this tf file. 
    - variables.tf          :  It contains all the variables declared in the Cosmos DB (cosmos.tf).
    - output.tf             :  It contains the output variables called from cosmos.tf file and can be accessed by other modules in main.tf using data source.
 
   ## Data Modules:

   The data_adgrouprole_assignments & data_sprole_assignments modules contain code for reading ad groups and service principle data for RBAC on Azure resources.

# main.tf:

- This file contains the main set of configuration code for the modules. In this file we call the modules of the specific resources to deploy on azure platform.

- Single module can be called multiple times for creating same set of resources with different naming convention and configuration.

# Variables.tf:

- This contains the variable definitions for the module. When the module is used by others, the variables will be configured as arguments in the module block. Variables with default values can also be provided as module arguments.

- The variables that are repeted / parameterized / evironment specific variables can be declared in this variables.tf file and can be called during deployment.

# Terraform Destroy pipeline:

- The Terraform Destroy pipeline will be used to destroy the environment specified in the tfstate file.

   
