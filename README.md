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


# Reason for this particular folder structure:

    A module is a container for multiple resources that are used together. Modules can be used to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

    To the Modularized code structure and Parameterization of the code.

    For creating multiple resources of the same type multiple times without modyfying the entire code using this modular structure.

# References
 
    - Low-Level Design document

    https://ts.accenture.com/:x:/r/sites/DigitalDataFlow-ACNOnly/Shared%20Documents/ACN%20Only/Azure_Platform_Infra/2_Design/Transcelerate%20-%20Low%20Level%20Design%20Document_Iteration2.xlsx?d=w13bf2fbdc42f45a784c2f8575d20b545&csf=1&web=1&e=me7ZSB
    
    - Setting up a new environment (end-end) document

    https://ts.accenture.com/:w:/r/sites/DigitalDataFlow-ACNOnly/Shared%20Documents/ACN%20Only/Azure_Platform_Infra/1_Plan-Analyze/WhiteBoards/SETTING%20UP%20SDR%20AZURE%20PLATFORM%20IN%20A%20NEW%20SUBSCRIPTION%20-%20DRAFT%20V2.0.docx?d=wd3a70669536f40c4a4f4d401386afa67&csf=1&web=1&e=laKZ8s


# 1. Docs 

    The docs folder consists of SDR Architechture Diagram and supporting documents.

# 2. Modules:

    This folder contains all the modular code for the below resources.

   ## Resource Group:
   
   This module contains the code for creating resource group on azure portal. This folder contains rg.tf, variables.tf & output.tf files.
   
    rg.tf         ->  It contains the terraform code for resource group creation.
    variables.tf  ->  It contains all the variables declared in the resource group (rg.tf).
    output.tf     ->  It contains the output variables called from rg.tf file and can be accessed by other  modules in main.tf using data source.

   ## Vnet:

   This module contains the code for creating Vnet on azure portal. This folder contains vnet.tf, variables.tf & output.tf files.
   
    vnet.tf         ->  It contains the terraform code for vnet creation. Any new configurations/settings in this tf file. 
    variables.tf    ->  It contains all the variables declared in the vnet (vnet.tf).
    output.tf       ->  It contains the output variables called from vnet.tf file and can be accessed by other  modules in main.tf using data source.

   ## Subnet:

   This module contains the code for creating Subnet on azure portal. This folder contains subnet.tf, variables.tf & output.tf files.
   
    subnet.tf       ->  It contains the terraform code for Subnet creation. Any new configurations/settings in this tf file. 
    variables.tf    ->  It contains all the variables declared in the Subnet (subnet.tf).
    output.tf       ->  It contains the output variables called from subnet.tf file and can be accessed by other modules in main.tf using data source.

   ## Delegated Subnet:

   This module contains the code for creating Delegated Subnet on azure portal. This folder contains delegated_subnet.tf, variables.tf & output.tf files.
   
    delegated_subnet.tf   ->  It contains the terraform code for Delegated Subnet creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the Delegated Subnet (delegated_subnet.tf).
    output.tf             ->  It contains the output variables called from delegated_subnet.tf file and can be accessed by other modules in main.tf using data source.

   ## Storage Account:

   This module contains the code for creating Storage Account on azure portal. This folder contains storage.tf, variables.tf & output.tf files.
   
    storage.tf      ->  It contains the terraform code for Storage Account creation. Any new configurations/settings in this tf file. 
    variables.tf    ->  It contains all the variables declared in the Storage Account (storage.tf).
    output.tf       ->  It contains the output variables called from storage.tf file and can be accessed by other  modules in main.tf using data source.

   ## Key Vault:

   This module contains the code for creating Key Vault on azure portal. This folder contains key_vault.tf, variables.tf & output.tf files.
   
    key_vault.tf          ->  It contains the terraform code for Key Vault creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the Key Vault (key_vault.tf).
    output.tf             ->  It contains the output variables called from key_vault.tf file and can be accessed by other modules in main.tf using data source.

   ## Log Analytics Workspace:

   This module contains the code for creating Log Analytics Workspace on azure portal. This folder contains log_analytics.tf, variables.tf & output.tf files.
   
    log_analytics.tf      ->  It contains the terraform code for Log Analytics Workspace creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the Log Analytics Workspace (log_analytics.tf).
    output.tf             ->  It contains the output variables called from log_analytics.tf file and can be accessed by other modules in main.tf using data source.

   ## Application Insights:

   This module contains the code for creating Application Insights on azure portal. This folder contains app_insights.tf, variables.tf & output.tf files.
   
    app_insights.tf       ->  It contains the terraform code for Application Insights creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the Application Insights (app_insights.tf).
    output.tf             ->  It contains the output variables called from app_insights.tf file and can be accessed by other modules in main.tf using data source.

   ## App Service Plan:

   This module contains the code for creating App Service Plan on azure portal. This folder contains appserviceplan.tf, variables.tf & output.tf files.
   
    appserviceplan.tf     ->  It contains the terraform code for App Service Plan creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the App Service Plan (appserviceplan.tf).
    output.tf             ->  It contains the output variables called from appserviceplan.tf file and can be accessed by other modules in main.tf using data source.

   ## App Service:

   This module contains the code for creating App Service on azure portal. This folder contains appservice.tf, variables.tf & output.tf files.
   
    appservice.tf         ->  It contains the terraform code for App Service creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the App Service (appservice.tf).
    output.tf             ->  It contains the output variables called from appservice.tf file and can be accessed by other modules in main.tf using data source.

   ## API Management:

   This module contains the code for creating API Management on azure portal. This folder contains apimanagement.tf, variables.tf & output.tf files.
   
    apimanagement.tf      ->  It contains the terraform code for API Management creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the API Management (apimanagement.tf).
    output.tf             ->  It contains the output variables called from apimanagement.tf file and can be accessed by other modules in main.tf using data source.

   ## Cosmos DB:

   This module contains the code for creating Cosmos DB on azure portal. This folder contains cosmos.tf, variables.tf & output.tf files.
   
    cosmos.tf             ->  It contains the terraform code for Cosmos DB creation. Any new configurations/settings in this tf file. 
    variables.tf          ->  It contains all the variables declared in the Cosmos DB (cosmos.tf).
    output.tf             ->  It contains the output variables called from cosmos.tf file and can be accessed by other modules in main.tf using data source.

# 3. Pipelines:

    This folder contains the yaml pipeline code (main_pipeline.yml) and parameters (parameters.yml) for deploying the moularized code on Azure Platform.

   ### Parameters.yml:

    This file contains parameters which are passed in the main_pipeline.yml. When the pipeline runs this parmeters will be fetched by the pipeline to deploy the code on Azure Platform.
 
   ### main_pipeline.yml:

    This Yml file contains the tasks and stages for deploying IAC code through ADO. Below are the tasks and stages we are leveraging in SDR.

   ## Stages & Tasks:

   ### Destroy:
   
   This stage is for destroying the deployed environment with IAC code. By default this stage is diabled to run, in order to execute this stage we have to check the "Destroy all the resources" while running the pipeline.

   #### Tasks:

    Terraform Install --> This task will install the terraform and it's dependencies on microsoft hosted agents to deploy the resources.

    Terraform Init --> This task initializes the terrafrom configuration files. this is the first command that should be run after writing a new terrafrom configuration or cloning an existing file.

    Terraform Destroy --> This task destroys all the resources configured via terraform.


   ### Checkov_Check:
   
   This stage will perform the security check on the terraform IAC code and generate the results on ADO under Test plans --> Runs.

   #### Tasks:

    Install Python --> This task will install required python packages for checkov.

    Publish Test Results --> This task will publish the IAC code security check results.

   ### Validate:
    
   This stage validate the terraform code and generate the artifacts.

   #### Tasks:

    Terraform Install --> This task will install the terraform and it's dependencies on microsoft hosted agents to deploy the resources.

    Terraform Init --> This task initializes the terrafrom configuration files. this is the first command that should be run after writing a new terrafrom configuration or cloning an existing file.

    Terraform Validate -->  This task validates the terraform configuration files and displays the errors if any (eg: IAC code syntax errors)

    Terraform Plan -->  This task creates an execution plan which lets us to review the changes made to the environment before applying the changes.

    Artifact Creation --> This task will create the artifact.

    Publish Artifact  --> This task will publish the artifact.

   ### Deploy:
   
   This stage will consume the artifact which generated on validate stage and deploy the resources on Azure Platform.
 
   #### Tasks:

    Terraform Install --> This task will install the terraform and it's dependencies on microsoft hosted agents to deploy the resources.

    Terraform Init --> This task initializes the terrafrom configuration files. this is the first command that should be run after writing a new terrafrom configuration or cloning an existing file.

    Terraform Apply --> This task execute the actions proposed in the terraform plan. It apply the changes and deploys the code to the azure platform.

# 4. main.tf:

    This file contains the main set of configuration code for the modules. In this file we call the modules of the specific resources to deploy on azure platform.

    Single module can be called multiple times for creating same set of resources with different naming convention and configuration.

# 5. Variables.tf:

    This contains the variable definitions for the module. When the module is used by others, the variables will be configured as arguments in the module block. Variables with default values can also be provided as module arguments.

    The variables that are repeted / parameterized / evironment specific variables can be declared in this variables.tf file and can be called during deployment.

    For deploying the new environment only the few parameters need to be passed/changed (Env_acronym, subscription_acronym, Address Space etc..) on the varaiable.tf without disturbing the entire code.

# Branch Merge strategy while performing changes/Building New Environment

   Whenever a new change request comes then we have to follow the below steps:

   Diagram of Branch/Merge Strategy can be found on “docs folder” . 

    Develop – Feature Consolidated 

    Feature (Test Env) - Developer’s Branches 

    Release – Iteration Branch 

    Staging – Developer's Branches 

    Environment – Environment Branches 

    Hotfix – Environment Hotfix Branches

#### Steps involved in Branch/Merge Strategy: 

    1. Every time you need to work on a new Iteration, the code needs to be pulled from Develop branch to Feature branch. 

    2. Once the code is ready with all the features/enhancements the code is then merged back into the Develop branch. 

    3. This code is then pushed to Release branch. 

    4. Once the code is pushed to Release the Develop branch can be deleted. 

    5. The Develop and Release branches has the Test environment data in it. To deploy the code to other environments like Dev, QA etc., it needs some changes to be made. So, the code is pulled into the Staging branches accordingly. 

    6. The Release branch stays the same and will have the same code to have a version control.  

    7. The code changes that are made for the environments are pushed into the Environment branches accordingly from the Staging. 

    8. After the code is deployed to Environments (Dev,QA etc), any hotfixes to be made are fixed in the Hotfix branches by pulling the code from respective Environment.  

    9. These hotfixes are worked upon separately for different environments and merged back into the respective environments. 

    10. When the next release (Iteration) starts the code is pulled directly from Dev branch which has the latest code with all the bug fixes into the Feature branch. 

    11. After all the features/changes are incorporated into the code, this is pushed into Develop branch and the flow from steps to 1 to 9 continues. 

    12. The code is pushed to Release branch from Develop branch and the Develop branch can be deleted. 

    13. From Release branch the code is pulled into the Staging branch and here the code gets ready for the environments. 

    14. The Release code remains the same and does not change as we have a different Release branch for next iteration. This is how we are handling version control. 

    15. From Staging the code is pushed to respective environments. 

# Files to be modify for configuration change / new environment build

### main.tf:
    
    For any configuration changes / adding new resource, this file needs to be modified.

### Variables.tf:

    For any configuration changes / adding new resource / new environment build, this file needs to be modified.
    Below are the parameters to be modified.
    env_acronym
    subscription_acronym (If the deployment is on new subscription, this varaiable need to change)
    address_space (Vnet)
    address_prefix (Subnet)
    dsaddress_prefix (Deligated Subnet)
    dsaddress_prefix2 (Deligated Subnet2)
    

### Parameters.yml:

    For new environment build, this file needs to be modified.
    Below are the two parameters to be modified.
    
        adoenvironment: 'Test'
        backendAzureRmKey: 'tfstatefiletestrbac.tfstate'

### Modules:

    For any new configuration settings for any resource, the specific resource.tf (Eg: vnet.tf) file needs to be modified.




































   

   
   

