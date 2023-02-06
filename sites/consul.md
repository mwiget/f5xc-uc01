```
/ # curl http://consul:8500/v1/catalog/datacenters
[
    "vela"
]
/ # curl http://consul:8500/v1/catalog/nodes
[
    {
        "ID": "a4fd870e-4ae1-2d21-6084-2d8cbbfb0186",
        "Node": "consul-58d46ffb4-vxb6c",
        "Address": "100.127.0.4",
        "Datacenter": "vela",
        "TaggedAddresses": {
            "lan": "100.127.0.4",
            "lan_ipv4": "100.127.0.4",
            "wan": "100.127.0.4",
            "wan_ipv4": "100.127.0.4"
        },
        "Meta": {
            "consul-network-segment": ""
        },
        "CreateIndex": 8,
        "ModifyIndex": 8
    }
]
/ # curl http://consul:8500/v1/catalog/services
{
    "consul": []
}
/ # 
```
