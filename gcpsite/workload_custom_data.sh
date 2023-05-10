#!/bin/bash
until ping -c3 -W1 1.1.1.1; do echo "waiting for internet connectivity ..." && sleep 5; done
snap install docker               
systemctl enable snap.docker.dockerd
systemctl start snap.docker.dockerd
sleep 30
docker run -d --net=host --restart=always \-e F5DEMO_APP=text \-e F5DEMO_NODENAME='Workload site' \-e F5DEMO_COLOR=ffd734 \
  -e F5DEMO_NODENAME_SSL='Workload' -e F5DEMO_COLOR_SSL=a0bf37 -e F5DEMO_BRAND=volterra public.ecr.aws/y9n2y5q5/f5-demo-httpd:openshift
docker run -d --name=tailscaled -v /var/lib:/var/lib -v /dev/net/tun:/dev/net/tun --network=host --privileged tailscale/tailscale tailscaled --state=/tmp/tailscaled.state
docker exec tailscaled tailscale up --authkey=${tailscale_key} --hostname=${tailscale_hostname}
