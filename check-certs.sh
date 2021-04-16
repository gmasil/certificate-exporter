#! /bin/bash

function printHeader () {
  echo "# HELP cert_days_remaining Days until the certificate becomes invalid"
  echo "# TYPE cert_days_remaining gauge"
}

function checkCert () {
  # load certificate
  certificate_file=$(mktemp)
  echo -n | openssl s_client -servername "${DOMAIN}" -connect "${DOMAIN}":443 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $certificate_file
  # get expiry date
  date=$(openssl x509 -in $certificate_file -enddate -noout 2> /dev/null | sed "s/.*=\(.*\)/\1/")
  # calc diff to today
  date_s=$(date -d "${date}" +%s)
  now_s=$(date -d now +%s)
  date_diff=$(( (date_s - now_s) / 86400 ))

  # output exporter data
  echo "cert_days_remaining{domain=\"${DOMAIN}\"} $date_diff"

  # cleanup
  rm "$certificate_file"
}


printHeader

for DOMAIN in $(echo $DOMAINS | tr "," "\n"); do
  checkCert
done
