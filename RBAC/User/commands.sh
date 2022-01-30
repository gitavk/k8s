mkdir ~/akuzmin1
cd ~/akuzmin1
openssl req -new -newkey rsa:2048 -nodes -days 3650 \
    -subj "/C=ES/ST=Málaga/L=Málaga/O=Playpit Labs Corp PLC/OU=IT/CN=akuzmin1" \
    -keyout akuzmin1.key \
    -out akuzmin1.csr

scp ~/akuzmin1/akuzmin1.csr master:/requests/akuzmin1/
scp ~/akuzmin1/akuzmin1.key master:/requests/akuzmin1/

# on master Node
cat /requests/akuzmin1/akuzmin1.csr | base64 | tr -d '\n'
kubectl get csr akuzmin1
kubectl certificate approve akuzmin1
# get Cluster’s CA Certificate From kube-public namespace
kubectl get cm -n kube-public kube-root-ca.crt -o jsonpath='{.data.ca\.crt}'
# get Cluster’s CA Certificate From Admin’s kubeconfig file
kubectl config view --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}' | base64 -d
# Setting Cluster name, Server, Cluster CA
kubectl config --kubeconfig=/requests/akuzmin1/akuzmin1.kubeconfig \
  set-cluster $(kubectl config view -o jsonpath='{.clusters[0].name}') \
  --server=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}') \
  --certificate-authority=ca.crt \
  --embed-certs=true
# Setting context, username
kubectl config --kubeconfig=/requests/akuzmin1/akuzmin1.kubeconfig \
  set-context akuzmin1 \
  --user=akuzmin1 \
  --cluster=$(kubectl config view -o jsonpath='{.clusters[0].name}')
kubectl config --kubeconfig=/requests/akuzmin1/akuzmin1.kubeconfig \
  use-context akuzmin1

# Add user’s certificate signed by Cluster
kubectl get csr akuzmin1 -o jsonpath='{.status.certificate}' | base64 -d > akuzmin1.pem
# generate config file
kubectl --kubeconfig=/requests/akuzmin1/akuzmin1.kubeconfig config \
  set-credentials akuzmin1 \
  --client-certificate=akuzmin1.pem \
  --client-key=akuzmin1.key \
  --embed-certs=true

# create role
kubectl create clusterrole node-viewer \
  --resource=nodes \
  --verb=list,get
# bind role
kubectl create clusterrolebinding node-viewer \
  --clusterrole=node-viewer \
  --user=akuzmin1

# check permissions
kubectl --kubeconfig=/requests/akuzmin1/akuzmin1.kubeconfig get nodes
# Using Client Config
kubectl --kubeconfig=/requests/akuzmin1/akuzmin1.kubeconfig auth can-i list nodes
# Using Admin Config
kubectl auth can-i list nodes --as=akuzmin1

# How to know if you need to use Role or ClusterRole?
# In a namespace
kubectl api-resources --namespaced=true
# Not in a namespace
kubectl api-resources --namespaced=false

# delete
kubectl delete clusterrolebindings.rbac.authorization.k8s.io node-viewer
kubectl delete rolebindings.rbac.authorization.k8s.io node-viewer
kubectl delete clusterrole node-viewer
kubectl delete csr akuzmin1
