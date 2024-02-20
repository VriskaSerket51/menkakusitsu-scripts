#!/bin/bash
# make_config.sh
# First argument: Client identifier

if [[ "$(whoami)" != "root" ]]; then
  echo "this script should be run as root!"
  exit 1
fi

usr=$(logname)
cd /home/$usr/easy-rsa/
echo "${1}" | ./easyrsa gen-req ${1} nopass
cp ./pki/private/${1}.key /home/$usr/client-configs/keys/
echo "yes" | ./easyrsa sign-req client ${1}
cp ./pki/issued/${1}.crt /home/$usr/client-configs/keys/

KEY_DIR=/home/$usr/client-configs/keys
OUTPUT_DIR=/home/$usr/openvpn-configs
BASE_CONFIG=/home/$usr/client-configs/base.conf
cat ${BASE_CONFIG} \
<(echo -e '<ca>') \
${KEY_DIR}/ca.crt \
<(echo -e '</ca>\n<cert>') \
${KEY_DIR}/${1}.crt \
<(echo -e '</cert>\n<key>') \
${KEY_DIR}/${1}.key \
<(echo -e '</key>\n<tls-auth>') \
${KEY_DIR}/ta.key \
<(echo -e '</tls-auth>') \
> ${OUTPUT_DIR}/${1}.ovpn

cd /home/$usr/client-configs
echo -e "vpn profile created: \n\n"
bash ./show_config.sh ${1}