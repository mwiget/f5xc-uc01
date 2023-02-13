# F5 XC Use Case with direct connect and express route

```
+--------------+ +--------------+  +--------------+ +--------------+  +-------------+ +-------------+
| spoke_vnet_a | | spoke_vnet_b |  |    spoke11   | |    spoke12   |  |   spoke21   | |   spoke22   |
|10.101.5.0/24 | |10.101.6.0/24 |  |10.100.1.0/24 | |10.100.2.0/24 |  |10.100.5.0/24| |10.100.6.0/24|
+--------------+ +--------------+  +--------------+ +--------------+  +-------------+ +-------------+
        +---------------+                  +---------------+                +-----------------+
        |   vela-vnet1  |                  |   vela-tgw1   |                |    vela-tgw2    |
        | 10.101.4.0/24 |                  | 10.100.0.0/24 |                | 10.100.4.0.0/24 |
        +---------------+                  +---------------+                +-----------------+
                                                        |                      |
+---------------+          { Internet }              +----------------------------+ 
|    vela-dc1   |                                    |         on-prem lab        |
| 10.100.0.0/24 |                                    |        10.200.0.0/22       | 
+---------------+                                    +----------------------------+
```

Sites:

- AWS TGW Site 1 
- AWS TGW Site 2 with standard vif to on-prem lab
- Azure Hub Site 1
- On-Prem DC Site 1, connected to AWS TGW site 1 via Direct connect
- On-Prem DC Site 2, connected via on-prem CE cluster
- Google Cloud Site 1

Folders:

- sites:
    - creates Spoke VPC and Hub VNETs. Could use count to create/delete as part of sites. Eliminates the need to pass VPC and VNET instances to sites.
    - creates AWS TGW, Azure VNET and on-prem CE sites (spke vpc and hub vnets are attached here)
    - create workloads, with ssh access from jumphost IP

