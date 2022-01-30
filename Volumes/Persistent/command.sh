kubectl get pv
kubectl get pv PV_NAME -o yaml
kubectl describe pv PV_NAME 
kubectl get storageclass SC_NAME
kubectl describe storageclass SC_NAME
kubectl patch storageclass STORAGE_CLASS_NAME -p '{
  "metadata": {
    "annotations": {
      "storageclass.kubernetes.io/is-default-class":"true"
    }
  }
}'
