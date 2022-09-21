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
