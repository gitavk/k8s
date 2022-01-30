POD=$(kubectl get pod -l application=scapegoat -o custom-columns="POD:.metadata.name" --no-headers)
kubectl exec -it ${POD} -- env | egrep '(REQUEST|LIMIT)'
