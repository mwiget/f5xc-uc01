# F5 XC Use Case with direct connect and express route

Folder sites:

- AWS TGW Site 1 with standard vif to on-prem lab
- AWS TGW Site 2 
- Azure Hub Site 1, spoke_vnet_b disconnected
- On-Prem lab secure mesh site vsphere1 (single interface)
- On-Prem lab secure mesh site vsphere2 (inside with dhcp services)

Folder arcadia:

- Deploys workloads with arcadia demo app.

Folder alpine-vk8s: work-in-progress

Folder f5-demo-httpd: obsolete. Replaced by arcadia

Folder iperf3: obsolete. Deploys workload with iperf3 in workloads behind sites
