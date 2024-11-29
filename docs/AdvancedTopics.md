<!--- Add MDR-RA consortium image --->
<p align="center">
    <img src="imgs/mdr-ra.png" alt="mdr-ra.png" width=400 />
</p>

# Advanced Topics Documentation

## Synopsis

## Table of Contents

1 [Opal-DataSHIELD architecture components](#1-opal-datashield-system)
<br>2 [OBiBa Opal System](#1-obiba-opal-system)
<br>&nbsp; 2.1 [Authentication](#12-authentication)
<br>3 [Docker Compose](#3-docker-compose)

## 1 Opal-DataSHIELD architecture components

1.  **Client-Side Components**
    -  DataSHIELD Client: Implemented in an R or Python environment. It provides users with tools to initiate secure computations on remote datasets.
    - Commands and Scripts: Users interact with the DataSHIELD client through functions designed to execute statistical or analytical tasks without directly exposing raw data.
2. **Server-Side Components**
    - Opal Server: The Opal server acts as the primary repository and computation node at each partner site holding data.
    - Functionalities: It stores sensitive datasets in a secure and controlled environment and executes commands sent by the client ensuring compliance with privacy rules.
    - DataSHIELD R Server: Installed on each Opal server, this package interprets client commands and ensures computations are compliant with data protection policies.
3. **Federated Computation**
    - Each server independently processes client requests on its local data.
    - Results from all partner servers are aggregated at the client side, ensuring no individual-level data is disclosed during the process.
4. **Security and Privacy Measures**
    - Non-Disclosure Compliance: Commands that might reveal individual data are blocked by the server.
    - Audit Trails: Both client and server interactions are logged for transparency and compliance.
    - Authentication and Authorization: Secure login and access controls restrict users interaction with the servers.

## 2 OBiBa Opal System
### 2.1 Authentication

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
The `docker-compose.yml` file pulls the following images from Docker Hub (https://hub.docker.com/):
- `traefik:v2.10` (container name: `traefik`): Traefik is a modern HTTP reverse proxy and ingress controller that makes deploying microservices easy (https://hub.docker.com/_/traefik). 
- `obiba/opal:5.0.0-RC4` (container name: `opal`): Opal is OBiBa's core data managment application (https://hub.docker.com/r/obiba/opal). 
- `mongo:6.0` (container name: `mongo`): MongoDB document databases provide high availability and easy scalability (https://hub.docker.com/_/mongo).
- `mysql` (container name: `mysql`): MySQL is a widely used, open-source relational database management system (RDBMS) (https://hub.docker.com/_/mysql). 
- `mariadb` (container name: `mariadb`): MariaDB Server is a high performing open source relational database, forked from MySQL (https://hub.docker.com/_/mariadb).
- `postgres` (container name: `postgres`): The PostgreSQL object-relational database system provides reliability and data integrity (https://hub.docker.com/_/postgres).
- `datashield/rock-base:latest` (container name: `rock`): OBiBa/Rock R server with dsBase setup (https://hub.docker.com/r/datashield/rock-base).
