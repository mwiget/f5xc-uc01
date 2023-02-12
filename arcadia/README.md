# arcadia finance demo app

F5 arcadia finance demo app used from https://gitlab.com/arcadia-application

Exposed via public vip via delegated domain at 
https://https://arcadia.acmecorp-prod.f5xc.app (login matt/ilovef5)

application components deployed in workload instances:

| application | site        | comments                                                           |
|-------------|-------------|--------------------------------------------------------------------|
| mainapp     | aws tgw1    | origin pool exposed via public vip load balancer to all F5 XC RE's |
| backend     | aws tgw2    | origin pool exposed via load balancer on aws tgw1                  |
| app2        | azure vnet1 | routed from public vip load balancer to origin pool on vnet1       |
| app3        | t.b.d.      | routed from public vip load balancer to origin pool on vnet1       |

```
+--------------+       +--- aws tgw1 ----+       +--- aws tgw2 ---+
|      lb      |       |                 |       |                |
|  public vip -----------> op mainapp    |       |                |
|       \      |       |   lb backend --------------> op backend  |
|        \     |       |                 |       |                |
|         \    |       +--- us-west-2 ---+       +-- us-east-1 ---+
|          \   |       
|           \  |       +-- azure vnet1 --+
|     F5     \ |       |                 |
| distributed `-----------> op app2      |
|    cloud     |       |                 |
+--------------+       +---- westus2 ----+
```

