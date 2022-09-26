- [Solution Overview](#solution-overview)
- [High Level Solution Architecture](#high-level-solution-architecture)
- [Architecture Goals and Constraints](#architecture-goals-and-constraints)
- [Architecture Goals/Objectives](#architecture-goals/objectives)
- [Architectural Assumptions and Decisions](#architectural-assumptions-and-decisions)
- [Solution Architecture Attributes](#solution-architecture-attributes)
- [Tools and Technologies](#tools-and-technologies)
- [Patterns](#patterns)
- [Authentication and Authorization](#authentication-and-authorization)
- [Portability](#portability)
- [Diagnostics and Logging](#diagnostics-and-logging)
- [Alerting](#alerting)
- [Application Architecture](#application-architecture)
- [Front End Application (UI)](#front-end-application-ui)
- [API Layer](#api-layer)
- [API Service Specifications](#api-service-specifications)
- [API Architectural Style](#api-architectural-style)
- [API Component Model](#api-component-model)
- [Data Architecture](#data-architecture)
- [Conceptual/Logical Data Model](#conceptual/logical-data-model)
- [Data Sources](#data-sources)
- [Data Dictionary](#data-dictionary)
- [Security Architecture](#security-architecture)
- [Security Solution Overview](#security-solution-overview)
- [Infrastructure](#infrastructure)
- [Azure Platform Components](#azure-platform-components)
- [Environment Strategy for SDR](#environment-strategy-for-sdr)
- [Deployment Models](#deployment-models)
- [Appendix A - Key Terms](#appendix-a-key-terms)

# Solution Overview
Digital Data Flow (DDF) is TransCelerate’s vision to catalyze an industry-level transformation, enabling digital exchange of study definitions (e.g., protocol) by collaborating with standards bodies to create a sustainable open-source Study Definition Repository (SDR) Reference Implementation based upon a standardized model – the Unified Study Definitions Model (USDM). The SDR Reference Implementation seeks to transform the drug development process by enabling a digital workflow to move from a current state of manual asset creation to a future state of fully automated and dynamic readiness to support clinical study execution. 

Figure 1 - Solution Overview Diagram
 
## High Level Solution Architecture
Figure:High Level Solution Architecture Diagram, below depicts high level architecture of the SDR Reference Implementation which is built using Angular Front End and.NET 6 Backend and deployed in Microsoft Azure Cloud. The solution architecture components are chosen in a way to support TransCelerate’s objectives of making the future releases cloud and vendor agnostic and support portability and deployment of the reference implementation to other environments such Amazon Web Services Cloud (AWS).
For the Reference Implementation, the vision is to leverage the USDM provided by CDISC by building a repository to house the USDM complying study data, establishing inbound APIs to enable **upstream systems (e.g., study builders (SB), protocol authors)** to input data, and outbound API to enable outward flow of data to **downstream systems (e.g., Electronic Data Capture systems (EDC)** to automate study start-up activities.

Figure 2 - High Level Solution Architecture Diagram
 
# Architecture Goals and Constraints
This section provides a description of goals and constraints of Solution Architecture. 
## Architecture Goals/Objectives
The architecture for the SDR Reference Implementation has been designed to achieve the following key objectives and architectural goals. The architectural components are chosen in a way to meet the foundational business requirements of being vendor, cloud, and system agnostic.<br>
•	**Cloud Agnostic / Open-Source** - Create an application that is relatively cloud agnostic from an implementation perspective by choosing technology stack and cloud components/services that offer extensibility and portability to the application.<br>
•	**Accelerate study start-up / execution** by enabling the automation of data flow to downstream clinical systems which reduces the need for duplication, manual input, and transcription.<br>
•	**Reduce Manual input** by creating an application that automates data flow.<br>
•	Open API Specifications with REST endpoints to maximize system interoperability and promote collaboration.

## Architectural Assumptions and Decisions
The SDR Reference Implementation will leverage Microsoft Azure Cloud Components and services for development and deployment. The choice of solution components, however, has been made to achieve key architectural goals and objects listed in section 2.1 above. Following are some of the key architectural decisions made for the SDR Reference Implementation. 
#### Table 1 - Architectural Decisions
|Area	|Decision|
|---|---|
|Connectivity|	OAS compliant RESTful API interfaces operate on a Push / Pull model – the upstream vendor is responsible for pushing data into the SDR and the downstream vendor is responsible for pulling data from the SDR. Import and Export functionality within the SDR will be considered for future release.  Event based notifications and/or support for GraphQL will be considered in future releases.|
|Role Based Access Control	|Role Based Access Controls are designed for accessing different components and PAAS services within Azure. However, for the purpose of MVP, it will have single role type for the necessary users|
|Database	|No SQL Database (Cosmos DB) is used to define the Application Data Model and support data versioning, data encryption as well as data partitioning standards. Additionally, it also disallows the import of data that is not in USDM format. Mongo DB interface will be used by the application layer to connect to Cosmos DB, allowing for deployment using Mongo DB in other environments.|
|Authentication and Authorization|Azure Active Directory (OAuth 2.0) is used to authenticate the user access to the SDR UI and APIalong with Certificate based authentication.|
|Versioning|Study Definitions stored in the repository and assigned a version generated and maintained by the SDR Application|
|Auditing	|EntryDatetime and EntrySystem are captured in the Audit Log for SDR Reference Implementation|

## Solution Architecture Attributes
### Tools and Technologies
The SDR Reference Implementation is built on Azure technology, however, the application components are designed keeping in mind portability and interoperability to other systems or cloud environments such as Amazon Web Services (AWS), Google Cloud Platform (GCP) etc.
Below is the list of Tools and Technologies adopted in designing & developing the DDF SDR Reference Implementation.
#### Table 2 - Tools and Technologies
|Cloud Services (Azure)|Front End UI Application|Backend API Application	|Dev ops|	Testing|
|---|---|---|---|---|
|•	Azure Subscription (ACP)<br>&nbsp;&nbsp;&nbsp;•	Azure AD (OAUTH 2.0) for Authentication/Security <br>&nbsp;&nbsp;&nbsp;•	Azure API Management <br>&nbsp;&nbsp;&nbsp;•	Azure App Service <br>&nbsp;&nbsp;&nbsp;•	Azure Cosmos DB (Mongo API) <br>&nbsp;&nbsp;&nbsp;•	Azure Key Vault <br>&nbsp;&nbsp;&nbsp;•	Azure Monitor <br>|Angular 11 <br>&nbsp;&nbsp;&nbsp;Bootstrap <br>&nbsp;&nbsp;&nbsp;HTML5 <br>|.Net 6<br>&nbsp;&nbsp;&nbsp; .Net Entity Framework 5  <br>|Terraform<br>&nbsp;&nbsp;&nbsp;GitHub<br>|Functional Testing:<br>&nbsp;&nbsp;&nbsp;•	NUnit Testing<br>&nbsp;&nbsp;&nbsp;•	Postman for API Testing<br>&nbsp;&nbsp;&nbsp;•	SDR UI - Manual <br>&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;Non-Functional Testing:<br>&nbsp;&nbsp;&nbsp;•	JMeter for performance testing<br>|

