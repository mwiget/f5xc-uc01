#!/bin/bash
until ping -c3 -W1 1.1.1.1; do echo "waiting for internet connectivity ..." && sleep 5; done
snap install docker               
systemctl enable snap.docker.dockerd
systemctl start snap.docker.dockerd
sleep 30
docker run -d --name=tailscaled -v /var/lib:/var/lib -v /dev/net/tun:/dev/net/tun --network=host --privileged tailscale/tailscale tailscaled --state=/tmp/tailscaled.state
docker exec tailscaled tailscale up --authkey=${tailscale_key} --hostname=${tailscale_hostname}
