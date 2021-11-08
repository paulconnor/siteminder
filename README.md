# Siteminder Sample Helm Chart

## 1. Add the Helm Chart and deploy

> helm repo add sm_helm_charts https://paulconnor.github.io/siteminder/

> helm repo update*

## 2. Set environment variables
> export SM_ADMIN_USER=$(echo \<admin-user\> | base64 )
 
> export SM_ADMIN_PASSWORD=$( echo \<admin-password\> | base64 )
 
> export SM_NAMESPACE=<>
 
> export SM_FQDN=<>
 
> export SM_HOME=/home/rapidsso
 
> export SM_CERTFILE=${SM_HOME}/certs/my-server.crt

> export SM_KEYFILE=${SM_HOME}/certs/my-server.key

## 3. Install 
kubectl create ns ${SM_NAMESPACE}

helm install rapidsso sm_helm_charts/siteminder -n ${SM_NAMESPACE} --set siteminder.username=${SM_ADMIN_USER} --set siteminder.password=${SM_ADMIN_PASSWORD} --set siteminder.namespace=${SM_NAMESPACE} --set siteminder.ag.fqdn=${SM_FQDN}

Wait for the Pods and Services to complete startup

## 4. Set some POD parameters to help scaling

Run the post-install.sh script
> ./post-install.sh 


## 5. Update your DNS or hosts file with the following

> kubectl get svc -n ${SM_NAMESPACE} | grep caag | awk -v host=${SM_FQDN}  '{print $4 " " host}'

