# Siteminder Sample Helm Chart

## 1. Add the Helm Chart and deploy

> helm repo add sm_helm_charts https://paulconnor.github.io/siteminder/

> helm repo update*


> export SM_ADMIN_USER=$(echo "admin-user" | base64 )
 
> export SM_ADMIN_PASSWORD=$( echo "admin-password" | base64 )
 
> export SM_NAMESPACE=<>
 
> export SM_FQDN=<>
 
> export SM_HOME=/home/rapidsso
 
> export SM_CERTFILE=${SM_HOME}/certs/my-server.crt

> export SM_KEYFILE=${SM_HOME}/certs/my-server.key

> helm install rapidsso sm_helm_charts -n ${SM_NAMESPACE} --set siteminder.username=${SM_ADMIN_USER} --set siteminder.password=${SM_ADMIN_PASSWORD} --set siteminder.namespace=$(SM_NAMESPACE} --set siteminder.ag.fqdn=${SM_FQDN}
   

## 2. Load your certificates for all CAAG PODS

Run the post-install.sh script



## 5. Update your DNS or hosts file with the following

> kubectl get svc -n ${SM_NAMESPACE} | grep caag | awk -v host=${SM_FQDN}  '{print $4 " " host}'

