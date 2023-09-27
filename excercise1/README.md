<<<<<<< HEAD

=======
# 52de37ec-0f4b-41dd-9ea0-203fec76acf2-CIDXXXXX

## Table of contents
---
- [52de37ec-0f4b-41dd-9ea0-203fec76acf2-CIDXXXXX](#52de37ec-0f4b-41dd-9ea0-203fec76acf2-cidxxxxx)
  - [Table of contents](#table-of-contents)
  - [Overview](#overview)
    - [Sale force member information](#sale-force-member-information)
    - [Connectivity Provider information](#connectivity-provider-information)
  - [Architecture HLD](#architecture-hld)
  - [Architecture LLD](#architecture-lld)
  - [Works with repo](#works-with-repo)


## Overview

### Sale force member information

* name
* email
* PM if exists

### Connectivity Provider information

* Are we the customer ISP? In case yes we need the network channel CID; Here the expectation is to obtain the relevant information about the external connectivity in case Liberty and whatever of his brands provide connectivity to the customer. Some examples:
  * Hybrid Solutions: Replications to Azure from On-premises where we're the connectivity provider.
  * VPNs: in case we're the Firewall administrators.

## Architecture HLD

- ![Arquitectura Rubis](../docs/images/image.png)


## Architecture LLD



[File LLD]

## Works with repo

Updates under this customer need to be worked through IaC. Follow to the next steps:

1. First, clone the repo
```bash
git clone https://csdrepo.csa-lla.com/cloud/csc/excercise-6
```
2. Change to the folder and create a new branch
```bash
git branch <RFC>
git switch <RFC>
```
3. Exec IaC changes, Don't forget to add documentation.
4. Apply changes 
5. push the new branch once time the changes have been applied successfully
6. Request the merge to the main.
>>>>>>> origin/brshaim
