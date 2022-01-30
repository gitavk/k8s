kubectl create secret docker-registry registry-cred \
 --docker-server=my.private-registry.com \
 --docker-username=akuzmin1 \
 --docker-password="myVeryStronPassword" \
 --docker-email=akuzmin1@mycompany.com \
 --namespace my-namespace
# the same use config file
kubectl create secret generic registry-cred \
  --from-file=.dockerconfigjson=PATH/TO/.DOCKER/CONFIG.JSON \
  --type=kubernetes.io/dockerconfigjson
# add permissions to allow service use the secret
kubectl patch serviceaccount default -n my-namespace \
  --patch '{
    "imagePullSecrets": [
      {
        "name": "registry-cred"
      }
    ]
  }'
# Search api groups
kubectl api-resources -o wide | grep CronJob

# From course
# Checking if RBAC is Enabled / Avaialble API Version:
kubectl api-versions | grep rbac
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1

# Creating resources:
kubectl create sa SA_NAME \
  --namespace=NAMESPACE_NAME

kubectl create role ROLE_NAME \
  --namespace=NAMESPACE_NAME \
  --verb=get,list,watch \
  --resource=pods,pods/status

kubectl create rolebinding ROLEBINDING_NAME \
  --role=ROLE_NAME \
  --serviceaccount=NAMESPACE_NAME:SA_NAME \
  --namespace=NAMESPACE_NAME

# Generating resources manifests:
kubectl create sa SA_NAME \
  --namespace=NAMESPACE_NAME \
  --dry-run=client \
  -o yaml

kubectl create role ROLE_NAME \
  --namespace=NAMESPACE_NAME \
  --verb=get,list,watch \
  --resource=pods,pods/status \
  --dry-run=client \
  -o yaml

kubectl create rolebinding ROLEBINDING_NAME \
  --role=ROLE_NAME \
  --serviceaccount=NAMESPACE_NAME:SA_NAME \
  --namespace=NAMESPACE_NAME \
  --dry-run=client \
  -o yaml

# Checking permissions:
kubectl auth can-i list pods \
  --as=system:serviceaccount:NAMESPACE_NAME:SA_NAME
