kubectl get configmap
kubectl get cm

kubectl describe configmap
kubectl describe cm

kubectl create configmap --help

kubectl exec -it user-pod -- printenv ENV_VARIABLE_NAME

kubectl exec team-volume-pod -- cat /data/team-members/user3

kubectl create configmap game-config --from-file=configmap/

kubectl get cm game-config -o yaml
kubectl get cm game-config -o jsonpath='{.data.game\.properties}'
