#!/bin/bash

#
# 1. Load your certificates for all CAAG PODS
#
# To generate one with Letsencrypt you first need to make sure your ${SM_FQDN} is DNS resolvable.
# Then get a certification on one of the CAAG PODS via the following command
#     -CMD_OUT=$(kubectl exec -n ${SM_NAMESPACE} -it ${CAAG_POD} -- /usr/local/bin/letsencrypt_ag.sh $SM_FQDN)
# Then copy the CERT and KEY to SM_CERTFILE and SM_KEYFILE respectively
#

if [ $(kubectl get secrets -n siteminder | grep rapidsso-cert | wc -l) -eq 1 ]
then
  kubectl delete secret -n ${SM_NAMESPACE}  rapidsso-cert
fi
kubectl create secret generic -n ${SM_NAMESPACE}  rapidsso-cert --from-file=key=$SM_KEYFILE --from-file=cert=$SM_CERTFILE



#
# 2. Register a trusted host and extract the secret for use by any CAAG POD wanting to connect to the Policy Manager
#
# Only need to register the trusted host once so use the first CAAG POD found and share the secret with the others via a restart of the deployment
#
PODS=$(  kubectl get pods -n siteminder | grep caag | awk '{ print $1 }' )
CAAG_POD=${PODS[0]}

CMD_OUT=$(kubectl exec -n ${SM_NAMESPACE} -it ${CAAG_POD} -- /opt/CA/sm-config/registerApp/registerApp.sh)
if [ "$?" -eq 0 ]
then
   printf "${CMD_OUT}\n"
   B64_SECRET=${CMD_OUT//[$'\t\r\n ']}
   kubectl patch secret -n ${SM_NAMESPACE}  rapidsso-sm-credentials -p="{\"data\":{\"secret\":\"${B64_SECRET}\"}}" -v=1
fi

#
# 3. Restart CAAG PODs to pickup the changes
#
kubectl rollout restart deployment/caag -n ${SM_NAMESPACE}

