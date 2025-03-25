<!--- Add MDR-RA consortium image --->
<p align="center">
    <img src="imgs/mdr-ra.png" alt="mdr-ra.png" width=400 />
</p>

# Advanced Topics Documentation

## Synopsis

## Table of Contents

1 [OBiBa Opal-DataSHIELD Ecosystem Overview](#1-obiba-opal-datashield-ecosystem-overview)
<br>&nbsp;&nbsp;1.1 [Client-Side Components](#11-client-side-components)
<br>&nbsp;&nbsp;1.2 [Server-Side Components](#12-server-side-components)
<br>&nbsp;&nbsp;1.3 [Federated Computation](#13-federated-computation)
<br>&nbsp;&nbsp;1.4 [Security and Privacy Measures](#14-security-and-privacy-measures)
<br>&nbsp;&nbsp;1.5 [Advantages of the Ecosystem](#15-advantages-of-the-ecosystem)
<br>2 [OBiBa Opal System](#1-obiba-opal-system)
<br>&nbsp;&nbsp;2.1 [Authentication](#12-authentication)
<br>3 [Docker Compose](#3-docker-compose)
<br>&nbsp;&nbsp;3.1 [Pulled Images](#31-pulled-images)
<br>4 [DataSHIELD Test Simulation](#4-datashield-test-simulation)
<br>&nbsp;&nbsp;4.1 [User Creation](#41-user-creation)
<br>&nbsp;&nbsp;4.2 [Data Upload](#41-data-upload)
<br>&nbsp;&nbsp;4.3 [Data Analysis](#41-data-analysis)

## 1 OBiBa Opal-DataSHIELD Ecosystem Overview

The OBiBa Opal-DataSHIELD ecosystem is a framework designed to enable 
privacy-preserving analysis of sensitive or distributed data. It leverages 
federated architecture, ensuring secure computation without compromising 
individual-level privacy. Below is an overview of its key components and 
functionalities.

### 1.1 Client-Side Components
---

- **DataSHIELD Client**
    <br>The client is implemented within R or Python environments, equipping 
    users with tools to initiate secure computations on remote datasets. It 
    abstracts the complexities of interacting with distributed servers into 
    user-friendly commands and workflows.

- **Commands and Scripts**
    <br>Users perform statistical or analytical tasks through predefined 
    DataSHIELD functions. These commands are designed to prevent exposure of raw 
    data by limiting operations to aggregate or anonymized results.

### 1.2 Server-Side Components
---

- **Opal Server**
    <br>Each Opal server serves as a secure repository and computation node for 
    local datasets. It is hosted **at partner sites** and ensures sensitive data 
    remains in a controlled environment.

    Functionalities:

    - Stores sensitive datasets with strict access controls.

    - Executes client-issued commands while ensuring compliance with privacy 
    regulations.
    
    - Enforces policies that prevent direct access to individual-level data.

- **DataSHIELD R Server**
    <br>This server-side package is an essential component installed on each Opal 
    server. It interprets DataSHIELD client commands, processes them locally, and 
    returns non-disclosive results in accordance with strict data protection 
    policies.

### 1.3 Federated Computation
---

- **Decentralized Data Processing**
    <br>Each Opal server processes client requests independently on its local 
    data. This ensures that sensitive data never leaves its original location.

- **Result Aggregation**
    <br>The client aggregates the results from multiple servers, enabling secure 
    cross-dataset analyses without exposing individual-level data from any source.

### 1.4 Security and Privacy Measures
---

- **Non-Disclosure Compliance**
    <br>Commands that could reveal individual data, such as row-level extractions, 
    are automatically blocked by the server.

- **Audit Trails**
    <br>All interactions between clients and servers are logged to maintain 
    transparency, support auditing, and ensure compliance with data protection 
    policies.

- **Authentication and Authorization**
    - Secure login mechanisms authenticate users before granting access.
    - Role-based access controls define user permissions, ensuring only authorized 
    individuals can interact with datasets and servers.

- **Encryption**
    <br>Data in transit between the client and servers is encrypted to protect 
    against interception.

### 1.5 Advantages of the Ecosystem

- **Privacy-Preserving Analysis** 
    <br>Enables researchers to perform advanced analytics without compromising 
    data privacy.

- **Scalability** 
    <br>Supports a distributed network of servers, making it suitable for 
    multi-partner projects of varying scales.

- **Regulatory Compliance** 
    <br>Adheres to stringent data protection regulations, such as GDPR, by 
    ensuring sensitive data never leaves its source location.

## 2 OBiBa Opal System

### 2.1 Authentication
---

In the OBiBa Opal-DataSHIELD ecosystem, users can authenticate by providing their *username* and *password* credentials to gain access to resources. Authentication ensures secure access and protects data integrity by verifying the identity of each user.

Required Credentials:
* **Username**
    - The unique identifier associated with a user's account in Opal.
    - A valid username must be paired with the corresponding password for successful authentication.

* **Password**
    - The secret key that verifies the user’s identity, ensuring access is restricted to authorized individuals.
    - A valid password must be paired with the correct username for successful login.

Authentication Workflow:
1. **User Login:** Enter both username and password credentials.
2. **Verification:** The system validates the credentials. If verified, access is granted to the specified resources; otherwise, the login attempt is denied.
3. **Access Control:** Upon successful authentication, the system applies predefined access controls based on the user's role, permissions, and associated datasets.

Other Authentication Options:

| **Login Strategy**                  | **Description**                                   | **Requirements**                                                 |
|-------------------------------------|---------------------------------------------------|------------------------------------------------------------------|
| **Username/Password**               | Login using a username and password.              | - Username<br>- Password |
| **Username/Password + OTP**   | Login using a username, password, and a time-based one-time password (TOTP) code for users with 2FA enabled. | - Username<br>- Password<br>- TOTP Code |
| **Personal Access Token (PAT)**     | Login using a personal access token, which replaces the need for a password.  | - PAT |
| **Key Pair in PEM Format**          | Login using a key pair (public and private key) in PEM format.                | - Key Pair |

## 3 Docker Compose

### 3.1 Pulled Images
---

The docker-compose.yml file pulls the following images from [Docker Hub](https://hub.docker.com/), 
each serving a specific role within the ecosystem. Below is a detailed overview of 
the images:

1. `traefik:v3.3.2` (container name: `traefik`)
    
    - **Role**: HTTP reverse proxy and ingress controller.
    
    - **Description**: Traefik simplifies the deployment and management of 
    microservices by providing a dynamic routing and load-balancing solution. It 
    integrates seamlessly with container orchestration platforms, supporting 
    features such as automatic HTTPS, service discovery, and health checks.
    
    - **Use in Ecosystem**: Acts as a gateway to route external requests to the 
    appropriate services within the ecosystem.

    - **More Information**: [Traefik on Docker Hub](https://hub.docker.com/_/traefik)

2. `obiba/opal:5.0.3`(container name: `opal`)

    - **Role**: Core data management application.

    - **Description**: Opal, developed by OBiBa, is designed for secure and 
    scalable data management. It serves as the primary interface for storing and 
    accessing datasets in distributed data analysis scenarios.

    - **Use in Ecosystem**: Hosts sensitive datasets locally while supporting 
    secure communication with the DataSHIELD client.

    - More Information: [Opal on Docker Hub](https://hub.docker.com/r/obiba/opal)

3. `mongo:8.0.4` (container name: `mongo`)
    - **Role**: NoSQL database.

    - **Description**: MongoDB is a document-oriented database that provides high 
    performance, scalability, and flexibility for handling JSON-like data 
    structures.

    - **Use in Ecosystem**: Stores metadata and other supporting information 
    required by Opal.

    - **More Information**: [MongoDB on Docker Hub](https://hub.docker.com/_/mongo)

4. `mysql:9.1.0` (container name: `mysql`)

    - **Role**: Relational database management system (RDBMS).

    - **Description**: MySQL is an open-source RDBMS widely used for managing 
    structured data efficiently.

    - **Use in Ecosystem**: Provides database support for applications that 
    require a structured data storage backend.

    - **More Information**: [MySQL on Docker Hub](https://hub.docker.com/_/mysql)

5. `postgres:17.2` (container name: `postgres`)

    - **Role**: Object-relational database system.

    - **Description**: PostgreSQL, known for its robustness and advanced features, 
    provides a highly reliable and scalable solution for managing structured data 
    with support for complex queries and transactions.

    - **Use in Ecosystem**: Provides backend database functionality for tools 
    requiring object-relational database features.

    - **More Information**: [PostgreSQL on Docker Hub](https://hub.docker.com/_/postgres)

7. `datashield/rock-base:latest` (container name: `rock`)

    - **Role**: R server with DataSHIELD support.

    - **Description**: The `rock-base` image provides an R server preconfigured 
    with DataSHIELD's `dsBase` package, enabling secure statistical analysis while 
    protecting individual-level data.

    - **Use in Ecosystem**: Facilitates privacy-preserving computations on 
    sensitive data within the federated Opal-DataSHIELD architecture.

    - **More Information**: [ROCK Base on Docker Hub](https://hub.docker.com/r/datashield/rock-base)

## 4 DataSHIELD Test Simulation
In the ```Test_Datashield``` folder, you can find R scripts and data to run a DataSHIELD test simulation.<br>
The R scripts can run on a PC, workstation, or server inside or outside your institution's network if the Opal-DataSHIELD server is externally accessible via https://your-domain, directed to port 443.
If the server is only accessible within your institution's network, the scripts must be run locally using https://your-domain or https://your-IP:443.
To check if your Opal-DataSHIELD server is running and accessible, open https://your-domain in a browser.

**NOTE:** The following system-level dependencies are required and can be installed on Linux (e.g., Ubuntu Server) using ```sudo apt-get```:
- `openssl-devel`
- `curl-devel`
- `libxml2-devel`
- `cmake`
  
**NOTE:** In all scripts, the URL string must be replaced with your domain, as in the ```MDR_RA.env``` file.

### 4.1 User Creation (Administrator-Only Task)
The ```Create_User_Datashield/users.R``` script can be executed by the system administrator to create a new
user dedicated to data analysis. The password must be generated according to the following requirements:
- at least 8 characters long;
- one digit;
- one uppercase letter;
- one lowercase letter;
- one special character (e.g., @#$%^&+=!);
- no white space. 


### 4.2 Data Upload (Administrator-Only Task)
The ```Load_Test_Data/Test-datashield-load-data_as_resource.R``` script can be executed by the system administrator to 
upload data to the server as a resource. This is particularly useful when data can not be stored in a table format. 
In this simulation, the data uploaded as a resource can be found in the ```Data``` folder.  

The ```Load_Test_Data/Test-datashield-load-data_as_table.R``` script can be executed by the system administrator to 
upload data to the server as a table.  


### 4.3 Data Analysis
The ```Load_Test_Data/Test-datashield-Analyze-data_in_resource.R``` script can be executed by authorized users to 
run an analysis on a resource. 

The ```Test-datashield-Analyze-data_in_table.R``` script can be executed by authorized users to 
run an analysis on a table.      

    

