# F5 XC Use Case 01

Sites:

- AWS TGW Site 1 with standard vif to SJ lab. Either us-west-2 or us-east-1
- AWS TGW Site 2
- Azure Hub Site 1
- On-Prem DC Site 1, connected to AWS TGW site 1 via Direct connect
- On-Prem DC Site 2, connected via on-prem CE cluster
- Google Cloud Site 1

Folders:

- sites:
    - creates Spoke VPC and Hub VNETs. Could use count to create/delete as part of sites. Eliminates the need to pass VPC and VNET instances to sites.
    - creates AWS TGW, Azure VNET and on-prem CE sites (spke vpc and hub vnets are attached here)
    - create workloads, with ssh access from jumphost IP

