prototype for GCP 3-node site with hub and spoke

```
      { Internet }
           |
+---------------------+
| Transit/Outside VPC |
|   10.102.32.0/24    |
+---------------------+
           |
     +-----------+
     | vela-gcp1 |
     +-----------+
           |
  +----------------+   +---------------+
  | Hub/Inside VPC |   |   Spoke1 VPC  |
  | 10.102.33.0/24 |---| 10.105.0.0/24 |
  +----------------+   | workload app  |
                       +---------------+
```

Web server server is deployed on workload instance in spoke1, running at port 8080.
The distributed app vela-app1 uses the webserver in spoke1 as origin server and exposes
it on port 80 on inside VIP 10.10.10.10 on cloud site vela-gcp1.

