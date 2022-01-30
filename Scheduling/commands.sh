kubectl label nodes node01 topology.kubernetes.io/zone=eu-east-1b

kubectl get nodes --label-columns=topology.kubernetes.io/region,topology.kubernetes.io/zone

kubectl get nodes -o custom-columns=NAME:.metadata.name,ZONE:'.metadata.labels.topology\.kubernetes\.io/zone'

# create taint
kubectl taint nodes node1 key1=value1:NoSchedule
# delete taint minus at the end
kubectl taint nodes node1 key1:NoSchedule-
# get node taint
kubectl get nodes -o json | jq '.items[].spec.taints'
kubectl get node NODE_NAME -o json | jq '.spec.taints'

# move node to the maintenance work
kubectl drain NODE_NAME 
kubectl drain NODE_NAME --ignore-daemonsets
# return the node back from the Maintenance
kubectl uncordon NODE_NAME
