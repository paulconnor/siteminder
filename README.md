# Siteminder Sample Helm Chart

## 1. Add the Helm Chart and deploy

> helm repo add sm_helm_charts https://paulconnor.github.io/siteminder/

> helm repo update


## 2. Install 
export SM_NAMESPACE=?your-namespace?

kubectl create ns ${SM_NAMESPACE} 

helm install rapidsso sm_helm_charts/siteminder -n ${SM_NAMESPACE} 

....Wait for the Pods and Services to complete startup

kubectl get pods,svc -n ${SM_NAMESPACE}


## 3. Update your DNS or hosts file with the following

> kubectl get svc -n ${SM_NAMESPACE} | grep caag | awk '{print $4 " rapidsso.iamdemo.broadcom.com" }'

## 4. Connect to the Policy Manager Admin UI (default user = siteminder/siteminder)

https://rapidsso.iamdemo.broadcom.com/iam/siteminder/adminui

## 5. Test out a protected realm pre-configured in the policy store.

https://rapidsso.iamdemo.broadcom.com/header.jsp

## 6. Scale the Access Gateway.

> kubectl scale deployments/caag -n ${SM_NAMESPACE} --replicas=2
