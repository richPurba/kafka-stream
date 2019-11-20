#!/usr/bin/env bash
set -eux

export PKI_CONFIG_DIR="/usr/share/kafka-client/conf"
echo "setting certificates...."
. get_signed_certificate.sh

export PKI_TRUSTSTORE
export PKI_TRUSTPASS
export PKI_KEYSTORE
export PKI_STOREPASS
export PKI_KEYPASS

exec  /usr/bin/java -jar /usr/share/kafka-client/streams.examples.jar