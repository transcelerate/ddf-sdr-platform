- [Introduction](#introduction)
- [Document Scope](#document-scope)
- [Out of Scope](#out-of-scope)
- [Audience](#audience)
- [Design Decision Point Matrix](#design-decision-point-matrix)
- [Consolidated Design Decisions and Recommendations](#consolidated-design-decisions-and-recommendations)
- [SDR Reference Implementation Solution Architecture](#sdr-reference-implementation-solution-architecture)
- [Governance](#governance)
- [Resource Groups](#resource-groups)
- [Resource Group Strategy](#resource-group-strategy)
- [Tagging](#tagging)
- [Resource Tag Taxonomy](#.resource-tag-taxonomy)
- [Resource Locks](#resource-locks)
- [Resource Locks for Critical Resources](#resource-locks-for-critical-resources)
- [Management and Monitoring](#management-and-monitoring)
- [Naming Conventions](#naming-conventions)
- [Cloud Foundation Naming Standards](#cloud-foundation-naming-standards)
- [Governance Decision Summary](#governance-decision-summary)
- [Subscriptions and Regions](#subscriptions-and-regions)
- [Subscriptions](#subscriptions)
- [Subscription Overview](#subscription-overview)
- [Subscription Scale Limitations](#subscription-scale-limitations)
- [Azure Active Directory (AD) Associated with Subscriptions](#azure-active-directory-ad-associated-with-subscriptions)
- [Subscription Management Roles](#subscription-management roles)
- [Azure Regions](#azure-regions)
- [Decision Summary](#decision-summary)
- [Networking](#networking)
- [VNets and Subnets](#vnets-and-subnets)
- [Networking Design Considerations](#networking-design-considerations)
- [DDoS Protection](#ddos-protection)
- [Basic DDoS Protection](#basic-ddos-protection)
- [Service Endpoints](#service-endpoints)
- [Azure VNet Service Endpoints](#azure-vnet-service-endpoints)
- [Decision Summary](#decision-summary)
- [Connectivity](#connectivity)
- [Connectivity](#connectivity)
- [Decision Summary](#decision-summary)
- [Identity](#identity)
- [Azure Active Directory and Federation](#azure-active-directory-and-federation)
- [AAD Tenant](#aad-tenant)
- [Azure Active Directory License](#azure-active-directory-license)
- [Account Security](#account-security)
- [Multi Factor Authentication](#multi-factor-authentication)
- [Administrative Scope](#administrative-scope)
- [Owner Permissions](#owner-permissions)
- [Managed Identity](#managed-identity)
- [Service Principal](#service-principal)
- [Role Based Access Control](#role-based-access-control)
- [Decision Summary](#decision-summary)
- [Security](#security)
- [Azure Key Vault](#azure-key-vault)
- [Key Vault Per Subscription](#key-vault-per-subscription)
- [Key Vault Security](#key-vault-security)
- [Key Vault Resiliency](#key-vault-resiliency)
- [Decision Summary](#decision-summary)
- [Certificates](#certificates)
- [Resources](#resources)
- [PaaS Components](#paas-components)
- [App Services](#app-services)
- [App Service Plans](#app-service-plans)
- [Azure CosmosDB](#azure-cosmosdb)
- [API Management](#api-management)
- [Operations](#operations)
- [Logging](#logging)
- [Diagnostic Settings](#diagnostic-settings)
- [Log Analytics Workspace](#log-analytics-workspace)
- [Application Insights](#application-insights)
- [Monitoring](#monitoring)
- [Azure Monitor](#azure-monitor)
- [Azure Network Watcher](#azure-network-watcher)
- [Decision Summary](#decision-summary)
- [References](#references)
- [Appendix- A](#appendix-a)

# Introduction
This document details the infrastructure design for Azure environment utilized to deploy the Study Definition Repository (SDR) Reference Implementation. 

SDR design and implementation working sessions were focused on Azure foundational design to drive and confirm architecture design elements (Network segmentation, Connectivity, App Services, API Management, Operations, Logging & Monitoring), discuss best practices, capture gaps and important notes pertinent to core pillars of Azure Infrastructure while allowing the SDR to be vendor and system agnostic. This document is organized by infrastructure components and presented in a dependency-based order. The chapters related to Subscription, Networking/Connectivity and Identity are the critical infrastructure components, in that, workloads cannot be deployed to Azure without all these components.
	
## Document Scope
This document presents and explains the underlying infrastructure design for  SDR Reference Implementation. It answers the question, "Why was this piece/element of infrastructure design/deployed in this way?" The decisions and recommendations in this document are based to meet the fundamental business and architectural requirements as well we the established industry best practices. The document is structured to present the design, followed by the requirements and assumptions that were used as inputs, followed by any documented limitations.

## Out of Scope
This document is not a deployment document, it does not discuss or include deployment instructions, process, effort, or duration (deployment material is provided separately). The information presented in this document is a first iteration of the larger journey and is meant as a guide, and not intended to be the basis of a project plan. This document also does not address application architecture patterns or designs.

## Audience
This document assumes a 300-level knowledge of Azure concepts, components, and services. The audience for this document is:<br>
•	Able to understand the technical details associated with the Azure concepts and components<br> 
•	Able to understand the company’s future IT needs and direction, and correlate the needs with the SDR current design elements<br>
•	Is a decision maker or influencer

### Level 300:
Advanced material. In-depth understanding of features in a real-world environment, and strong coding skills. Provides a detailed technical overview of a subset of product/technology features, covering architecture, performance, migration, deployment, and development.

## Design Decision Point Matrix
Throughout the document several outputs are summarized in each section. These outputs are categorized under the following headings:

```
Note
This header is to make the reader aware of something specific in the document and will give some additional context to the section.
```
```
Important Note
This header is to ensure the reader is fully aware of the point being highlighted. The information provided should be fully considered when understanding the context of the section.
```
```
Recommendation
A recommendation being made by the infrastructure team, but not necessarily a design decision.
```
```
Assumption
Based on the workshops and knowledge of infrastructure, assumptions on configurations and requirements are captured.
```
```
Design Decision
A design decision based on SDR requirements and the recommended best practices.
```
# Consolidated Design Decisions and Recommendations
Please find below the summary of design decisions and recommendations for DDF SDR Azure infrastructure.

### Table 1 Design Decisions & Recommendations
|Module|	Design	|Decisions & Recommendations|
|---|---|---|
|Governance|Application Resource Group Strategy|Use separate Resource Groups for applications to enable independent Life Cycle|
|Governance|Infrastructure Resource Groups Strategy|Separate Resource Groups for infrastructure resources|
|Governance|ResourceTags|Use resource tagging for all the resources|
|Governance|Apply Resource Locks to Shared Resources|Use Resource Locks for Production and shared infrastructure resources|
|Governance|Log Analytics Deployment|Use a Centralized Log Analytics Instance|
|Governance|	Naming Convention|Custom naming convention based on best practices|
|Subscriptions and Regions|	Subscription Layout|Two Subscriptions for “Study Definition Repository”|
|Subscriptions and Regions|	Select Azure Regions|One Azure Region “East US” is used|
|Networking|	Protecting Public IPs|Setup VNets with basic DDOS protection for internal VNets|
|Identity	|Authentitcation|	Azure Active Directory Tennant|
|Identity	|Multi Factor Authentication|Use MFA for all Administrative Access Use and for all Users|
|Identity	|Admins and Administrative role Assignment|Limit the number of accounts with Owner rights|
|Identity	| Role-based access control (RBAC) Strategy|Built-in Azure roles will be leveraged for RBAC strategy|
|Resources	|App Services|Use 2 App Services per Environment/Subscription
|Resources|	App Service Plans|Use 2 App Service Plans per Environment/Subscription|
|Resources|	API Management|Use API Management to create API Gateways for the backend services|
|Resources|	CosmosDB|Use Azure CosmosDB API for MongoDB for NoSQL Database|
# SDR Reference Implementation Solution Architecture
The following diagram depicts SDR Reference Implementation Architecture. Key Design points are listed below: (Further details of the solution architecture are provided in supporting documentation).

Figure 1 SDR Reference Implementation Solution Architecture Design

# Governance
## Resource Groups 
A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that will be managed as a group. The operator decides the method to add resources to resource groups based on current needs for an organization. Generally, resources that share the same lifecycle are added to the same resource group for easier and more efficient deployment, update, and/or delete.

Resource Groups are a critical concept in Azure Resource Management. A Resource Group is:<br>
•	A logical grouping of resources<br>
•	A container for delegation of administration (current recommended best practice)<br>
•	A target for RBAC

### Resource Group Strategy
For SDR reference implementation separate Resource Groups for core (VNet, Subnets, Key Vault etc.) and app related (App Services, API Management, Application Insights etc.) infrastructure resources were used.

Generally, any centrally managed resources were grouped into separate Resource Groups and granted team’s permission to consume the resources. Resource Groups for core resources are broken out based on specific workload access requirements enabling explicit access controls and duty segregation.

RBAC is natively a part of Azure's management platform and is used to control access to resource groups. There are 3 core roles (Owner, Contributor, Reader) that can be applied to Resource Groups and users can be placed into one of those roles or custom roles can be created. The table below details the following initial resource groups, based on the above guidance. Within the Subscription the following Resource Groups have been created:

### Table 2 Resource Group Breakdown
|Resource Group|	Description|
|---|---|
|Core|A Resource Group containing the network infrastructure including the VNets/Subnets, Storage Account, etc. that are core to the entire infrastructure.This Resource Group should be locked with a “Delete” lock to prevent accidental deletion.|
|Application|	Resource Groups containing the application related resources like App Services, API Management, Application Insights etc.|

```
Design Decision
SDR reference Implementation has used Resource Groups for Core and Application related infrastructure resources.
```
Additional Resource Groups can be created for additional services as needed using the previously described guidelines.

## Tagging
Tags provide a way to logically organize resources with custom properties and can be applied to Resource Groups and/or directly to individual resources. Tags can be used to refine the selection criteria for resources or Resource Groups from the console, web portal, PowerShell, or the Azure resource API.

•	Tags are particularly useful when you need to organize resources for billing or management<br>
•	Tags can be applied to Resource Groups and to resources that support Azure Resource Manager (ARM) operations. All resources deployed into the SDR environment will be deployed using the ARM model and not the legacy model see as referenced in the ARM section<br>
•	Each resource or Resource Group can have a maximum of 50 tags<br>
•	Tags are key/value pairs, name is limited to 512 characters, value is limited to 256 characters<br>
•	Tags are free-form text so consistent, correct spelling and case-sensitivity is very important<br>
•	Tags defined on Resource Groups exist only on the Resource Group object; resources do not inherit the Resource Group’s tags<br>
•	Each tag is automatically added to the Subscription-wide taxonomy<br>
•	It’s important to develop a tag taxonomy early on and apply it consistently to all deployed resources<br>
•	Tags appear in billing and consumption reports<br>
•	Tags should not be used as a replacement for a proper CMDB. The information stored in tags has no inherent validation or relationship. Instead, the data in tags should reflect information that is contained within other systems such as the in-house developed CMDB for Application/Business Unit/Client information or a financial system for a tag such as a Cost Center

 ```
 Design Decision
SDR reference Implementation has used a standardized metadata taxonomy for all resources based on the table in the next section 4.2.1 (Table 3: SDR reference Implementation Azure Tags), that is applied to the resource at the time of resource creation using Terraform code deployment for consistency and an easily repeatable process.
```

### Resource Tag Taxonomy
SDR reference Implementation has used a standardized metadata taxonomy for all resources based on the following table, that is applied to the resource at the time of resource creation using Terraform code deployment for consistency and a repeatable, secure process.

### Table 3 SDR reference Implementation Azure Tags
|Tag Name|	Description|	Required/ Optional|	Value	|Resources|
|---|---|---|---|---|
|Environment|	This tag is to show which environment the resources are being deployed into.|	Required|	Dev/QA/Pre-Prod	|Resource Groups, VNet, API Management, App Services, App Service Plans, Storage Account, CosmosDB, Application Insights, Log Analytics Workspace & Key Vault|
|App Layer|	This tag is show which application layer the resource belongs to. |	Required|	Frontend / Backend / N/A|Resource Groups, VNet, API Management, App Services, App Service Plans, Storage Account, CosmosDB, Application Insights, Log Analytics Workspace & Key Vault|

## Resource Locks
Resource Locks allow administrators to lock Subscriptions, Resource Groups, or individual resources to prevent accidental (or malicious) deletion or modification of critical resources. Unlike Role-based access control (RBAC) management, locks apply a restriction across all users and roles. A lock on a parent scope applies to all child resources. Resource Locks use the least privilege model, meaning the most restrictive lock in the inheritance takes precedence. There are two types of locks:
##### •	Delete (CanNotDelete) – 
Authorized users can still read and modify a resource, but they can’t delete it.
##### •	Read-only (ReadOnly) –
Authorized users can read a resource, but they can’t delete or perform any actions on it.

### Resource Locks for Critical Resources
 ```
 Recommendation
Apply Resource Locks for Production environments
```

 ```
 Design Decision
SDR reference Implementation applied the Delete Lock (CanNotDelete) on all Resource Groups. The locks are applied at the Resource Group level. Locks applied to a Resource Group are also applied to all the resources that exist within that Resource Group.
```
## Management and Monitoring
Azure Monitor is an Azure’s native monitoring, alerting and visualization solution for Metrics and Logs generated by Azure resources (IaaS and PaaS).  Azure monitor collects data from variety of sources ranging from applications, OS and other enabling services and the underpinning platform itself. Secondly, data is collected for both the management plane (i.e., data about the operations done on the resource) and the data plane (i.e., data about operations happened inside the resource) of Azure resources. Data collected from compute resources (i.e., VMs) can be extended by installing Log Analytics and other Agents on them.

## Naming Conventions
The most recommended and critical standard to implement while deploying to cloud platforms is a Naming Convention. The importance of a naming convention standard is amplified especially knowing that deployed services cannot be renamed without being destroyed first.

As well, including relevant and key information in the name of a service can go a long way in minimizing troubleshooting time when an issue arises. Strong naming used in conjunction with tags can provide a breadth of information for users looking up workloads and services.

There are many ways to go about creating a naming convention that is universal across all services, but it makes more sense to create a convention per service or resource. The reason being is that not all services have the same requirements for names. As an example, all storage accounts must be lowercase alphanumeric values up between 3-24 characters in length whereas a VM resource is between 1- 64 characters but can use uppercase letters and special characters.

