<!--- Add MDR-RA consortium image --->
<p align="center">
    <img src="imgs/mdr-ra.png" alt="mdr-ra.png" width=400 />
</p>

# Advanced Topics Documentation

## Synopsis

## Table of Contents

1 [OBiBa Opal System](#1-obiba-opal-system)
<br>&nbsp; 1.1 [Authentication](#11-authentication)
3 [Docker Compose](#3-docker-compose)


## 1 OBiBa Opal System


### 1.1 Authentication

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
