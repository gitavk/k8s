kubectl get svc
kubectl get svc -o wide
kubectl get svc --all-namespaces
kubectl describe svc -n NAMESPACE SERVICE_NAME
kubectl get svc -n NAMESPACE SERVICE_NAME -o yaml

kubectl get ep
kubectl describe ep -n NAMESPACE SERVICE_NAME

kubectl expose deployment DEPLOY_NAME \
  -n NAMESPACE \
  --name SERVICE_NAME \
  --type SERVICE_TYPE \
  --port SERVICE_PORT \
  --target-port SERVISE_TARGET_PORT
  # SERVISE_TARGET_PORT== POD_CONTAINER_PORT
