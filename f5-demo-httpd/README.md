deploy F5 Demo NGINX from https://github.com/f5devcentral/f5-demo-httpd

```
$ ./validate.sh 
workload private_ip: 10.100.1.7 10.101.5.4 10.101.6.4 
ping from site tgw1 (alpine-68869c65b-hz4nv) ...
10.100.1.7 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 1.38/1.98/2.99
10.101.5.4 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 13.0/14.1/17.2
10.101.6.4 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 12.7/13.1/13.4

ping from site tgw2 (alpine-5d57fd5688-w4qcx) ...
10.100.1.7 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 63.3/64.0/65.0
10.101.5.4 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 74.5/86.4/89.8
10.101.6.4 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 72.8/74.6/77.1

ping from site vnet1 (alpine-67c484c96d-vk6tv) ...
10.100.1.7 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 14.0/14.6/16.4
10.101.5.4 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 1.05/1.20/1.31
10.101.6.4 : xmt/rcv/%loss = 5/5/0%, min/avg/max = 0.967/1.19/1.50
```

