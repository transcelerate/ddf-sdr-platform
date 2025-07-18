<img src="https://github.com/transcelerate/ddf-home/blob/main/media/images/Repos.png">

- [Introduction](#introduction)
  - [Requirements to Contribute and Propose Changes](#requirements-to-contribute-and-propose-changes)
- [Intended Audience](#intended-audience)
- [Overview](#overview)
  - [Pre-Requisites](#pre-requisites)
  - [Docker Compose Files](#docker-compose-files)
  - [Database Setup and Restoration](#database-setup-and-restoration)
    - [MongoDB Scripts](#mongodb-scripts)
    - [MongoDB Dump Directory](#mongodb-dump-directory)
  - [Environment-specific Configuration Variables](#environment-specific-configuration-variables)
  - [Running Docker Compose](#running-docker-compose)
    - [Local Development Environment](#local-development-environment)
    - [Base Environment](#base-environment)
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
- To the extent that the SDR Reference Implementation incorporates or relies on any specific branded products or services, such as Docker, this resulted out of the practical necessities associated with making a reference implementation available to demonstrate the SDR’s capabilities.  Users are free to download the source code for the SDR from GitHub and design their own implementations.  Those implementations can be in a containerization platform of the user's choice, and do not have to use Docker. 
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

The contents in this repository allows users to deploy SDR Reference Implementation Infrastructure using Docker containers. The deployment can be configured and executed using Docker Compose, leveraging environment variables to configure target environment specific values.

It assumes a good understanding of Docker concepts and containerization. The audience for this document should:

- have basic understanding of Docker and Docker Compose
- be familiar with container orchestration and management
- understand environment configuration through .env files
- have basic understanding of GitHub Actions, Secrets & Yaml Scripts (if using CI/CD)

# Overview

 This repository contains Docker Compose files and MongoDB scripts to facilitate local development and deployment of the SDR Reference Implementation.

## Pre-Requisites

- Docker Engine installed
- Docker Compose installed
- Network access to container registries:
  - Docker Hub
  - Microsoft Container Registry (mcr.microsoft.com)
  - GitHub Container Registry (ghcr.io)

## Docker Compose Files

- docker-compose.yml - Base configuration for all environments
- docker-compose.local.yml - Configuration overrides for local development

## Database Setup and Restoration

### MongoDB Scripts

This repository contains two scripts to help with MongoDB setup and data restoration. These scripts are used by the Docker Compose files to set up an empty MongoDB database for all environments and restore a database dump for local development.

- 01-mongodb-setup.sh - Sets up an empty MongoDB database with the required collections
- 02-mongodb-restore.sh - Restores a database dump using `mongorestore` from the `/mongodb_dump/SDR` directory

### MongoDB Dump Directory

To prepare the MongoDB data for restoration, create a directory named `mongodb_dump` in the project root, then place the `SDR` directory containing your MongoDB export files (JSON and BSON formats) within this directory.

## Environment-specific Configuration Variables

The `.env` file contains environment-specific configuration variables used by Docker Compose and the containerized applications. This file should never be committed to the repository as it may contain sensitive information.

Copy the provided `.env.template` file to create your own `.env` file. Edit the `.env` file and replace the placeholder values with your actual configuration values.

## Running Docker Compose

To start the services using Docker Compose, use one of the following commands based on your target environment:

### Local Development Environment

`docker-compose -f docker-compose.yml -f docker-compose.local.yml --env-file .env up --build`

### Base Environment

`docker-compose -f docker-compose.yml --env-file .env up --build`

# Support

- For any technical queries on SDR Platform repository, please create an issue [DDF SDR Support](https://github.com/transcelerate/ddf-sdr-support/issues/new?assignees=sdr-support&labels=techSupport&template=TechSupport.yml&title=%5BTechSupport%5D%3A).
