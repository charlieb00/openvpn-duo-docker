
# openvpn dockerfile
#
FROM charlieb00/docker-openvpn-duo:latest

MAINTAINER Charles Brown <charlibr@cisco.com>

ADD --chown=0755 bin/ovpn_run /usr/local/bin/
