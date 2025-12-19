<img src="https://github.com/transcelerate/ddf-home/blob/main/media/images/Repos.png">

- [Introduction](#introduction)
  - [Requirements to Contribute and Propose Changes](#requirements-to-contribute-and-propose-changes)
- [Intended Audience](#intended-audience)
- [Overview](#overview)
  - [Setup Process](#setup-process)
  - [Pre-Requisites](#pre-requisites)
  - [Docker Compose Files](#docker-compose-files)
  - [Database Setup](#database-setup)
    - [MongoDB Scripts](#mongodb-scripts)
  - [Environment-specific Configuration Variables](#environment-specific-configuration-variables)
  - [Running Docker Compose](#running-docker-compose)
    - [Development Environment](#development-environment)
    - [Production Environment](#production-environment)
- [Changes for Release V5.0 (September 2025)](#changes-for-release-v50-september-2025)
- [Support](#support)

# Introduction

The Study Definition Repository Reference Implementation (SDR RI) is part of the work of the Digital Data Flow initiative, which seeks to help transform the drug development process by enabling a digital workflow to move from a current state of manual asset creation to a future state of fully automated and dynamic readiness to support clinical study execution. This SDR Reference Implementation is based upon the Unified Study Definitions Model (USDM) which is a standardized format for a study definition defined by CDISC. This model is an evolving data model and this SDR Reference Implementation is built to support multiple versions of USDM that enables automated data exchange between the study builders and the EDC systems in clinical R&D.

The below document provides a high-level overview of the SDR Reference Implementation.
- [DDF SDR RI Solution Architecture Document](documents/sdr-release-v5.0/ddf-sdr-ri-solution-architecture-v7.0.pdf)

**NOTES:** 
- These materials and information are provided by TransCelerate Biopharma Inc. AS IS. Any party using or relying on this information and these materials do so entirely at their own risk. Neither TransCelerate nor its members will bear any responsibility or liability for any harm, including indirect or consequential harm, that a user may incur from use or misuse of this information or materials.
- An SDR is not mandatory to achieve end-to-end data flow but rather represents one potential solution that may support end-to-end data flow.  Nothing in this document should be construed as a recommendation that companies use an SDR or this SDR RI.  Companies are solely responsible for determining how to manage their own end-to-end data flow systems and processes.
- The SDR RI is not a commercial product, rather it is TransCelerate’s attempt to illustrate what might be possible in implementing the USDM developed by CDISC. To the extent that the SDR Reference Implementation incorporates or relies on any specific branded products or services, this resulted out of the practical necessities associated with making a reference implementation available to demonstrate the SDR’s capabilities.  TransCelerate does not endorse any particular software, system, or service.  And the use of specific brands of products or services by TransCelerate and its collaboration partners in developing the SDR Reference Implementation should not be viewed as any endorsement of such products or services.  Users can use the USDM for any purpose they choose and can build their own implementations of the SDR using the resources [available on GitHub](https://github.com/transcelerate).
- As of September 2025, the DDF initiative is still the process of setting up operations, and any pull requests submitted will not be triaged at this point in time.

## Requirements to Contribute and Propose Changes
Before participating, you must acknowledge the Contribution License Agreement (CLA).

To acknowledge the CLA, follow these instructions:

- Click [here](https://github.com/transcelerate/ddf-home/blob/main/documents/DDF_CLA_2022MAR28_FINAL.pdf) to download and carefully read the CLA.
- Print the document.
- Complete and sign the document.
- Scan and email a PDF version of the completed and signed document to [DDF@transceleratebiopharmainc.com](mailto:DDF@transceleratebiopharmainc.com?subject=Signed%20CLA).

NOTE: Keep a copy for your records.

# Intended Audience

The contents in this repository enable users to set up SDR Reference Implementation with Docker containers through their own GitHub repositories and workflows. 

It assumes a good understanding of Docker concepts and containerization. The audience for this document should:
- be familiar with Docker and Docker Compose
- be familiar with container orchestration and management
- understand environment configuration through `.env` files

# Overview

## Setup Process

**Important Note:** Refer to the [DDF SDR RI System Maintenance Guide Document](documents/sdr-release-v5.0/ddf-sdr-ri-system-maintenance-guide-v2.0.pdf) for setting up a running instance of SDR. 

## Pre-Requisites

- Docker Engine installed
- Docker Compose installed
- Network access to container registries:
  - Docker Hub
  - [Microsoft Container Registry](mcr.microsoft.com)
  - [GitHub Container Registry](ghcr.io)

## Docker Compose Files

- `docker-compose.yml` - Base configuration for all environments
- `docker-compose.dev.yml` – Configuration overrides for development environment
- `docker-compose.prod.yml` – Configuration overrides for production environment

## Database Setup

### MongoDB Scripts

This repository contains a script to set up the Mongo database. The script is used by Docker Compose files to set up an empty Mongo database for all environments.
- `01-mongodb-setup.js` - Sets up an empty Mongo database with the required collections

## Environment-specific Configuration Variables

The `.env` file contains environment-specific configuration variables used by Docker Compose and the containerized applications. This file should never be committed to the repository as it may contain sensitive information; hence it is excluded in the `.gitignore` file. 
Copy the provided `.env.template` file to create your own `.env` file. Edit the `.env` file and replace the placeholder values with your actual configuration values.

## Running Docker Compose

To start the services using Docker Compose, use one of the following commands based on your target environment:

### Development Environment

A development Docker Compose run will build the containers locally, from the `ddf-sdr-api` and `ddf-sdr-ui` repositories, when checked out alongside the `ddf-sdr-platform` repository.

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml --env-file .env up -d
```
See the System Maintenance Guide for Docker and .env settings to ensure that the early release CORE binary is used.

### Production Environment

The production Docker Compose runs using the published, prebuilt docker images of the API and UI:

```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env up -d
```

For the above command to execute correctly with the prebuilt API container that contains the pre-release CORE binary, you will need to edit the .env file to ensure the following reference to the core binary is used:

```bash
CDISC_RULES_ENGINE_RELATIVE_BINARY=cdisc-core-20250903
```

# Changes for Release V5.0 (September 2025)

SDR Release V5.0 marks a fundamental shift from previous versions by eliminating Azure dependencies from its architecture, more easily enabling platform-agnostic deployment capabilities across various environments.

# Support

- For any technical queries on SDR Platform repository, please create an issue [DDF SDR Support](https://github.com/transcelerate/ddf-sdr-support/issues/new?assignees=sdr-support&labels=techSupport&template=TechSupport.yml&title=%5BTechSupport%5D%3A).
