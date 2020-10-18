# tinyDNS
A containerized DNS server using Alpine and Dnsmasq.

## Prerequisites packages
```bash
* buildah
* podman
```

## Configure container storage (Optional)
```bash
su - root
vgcreate vgDATA /dev/vdb
lvcreate -n lvLIB -L 5G /dev/vdb
lvcreate -n lvRUN -L 5G /dev/vdb
mkfs -t xfs -n ftype=1 /dev/vgDATA/lvLIB
mkfs -t xfs -n ftype=1 /dev/vgDATA/lvRUN
mount /dev/vgDATA/lvLIB /var/lib/containers
mount /dev/vgDATA/lvRUN /var/run/containers
```

## Usage
### Open firewall port
```bash
firewall-cmd --add-service=dns --permanent
firewall-cmd --reload
```

### Clone git repository
```bash
git clone https://github.com/kevydotvinu/tinyDNS
cd tinyDNS
git checkout dnsmasq
```

### Build container image
```bash
buildah bud --security-opt label=disable --tag localhost/kevydotvinu/tinydns:dnsmasq .
```

### Run container image
```bash
podman run --rm \
           --interactive \
           --tty \
           --privileged \
           --net host \
           --volume "$(pwd)/dnsmasq.conf:/etc/dnsmasq.conf" \
           --volume "$(pwd)/dns.conf:/etc/dnsmasq.d/dns.conf" \
           --security-opt label=disable \
           --name tinydns localhost/kevydotvinu/tinydns:dnsmasq \
	   --interface eth0
```
To run the pod in background, replate --rm, --interactive and --tty with --detach.
