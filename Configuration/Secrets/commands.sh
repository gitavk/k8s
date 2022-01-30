kubectl create secret generic empty-secret
kubectl get secret empty-secret

kubectl create secret generic admin-secret --from-file=/data/
kubectl create secret generic devops-secret --from-literal=username=akuzmin1 --from-literal=password=akuzmin1_password --from-literal=email=akuzmin1@lab.playpit.net

echo -n 'admin' > username
echo -n '1f2d1e2e67df' > password

kubectl create secret \
  generic db-user-pass \
  --from-file=username \
  --from-file=password

echo -n 'username' | base64 -w0
echo 'dmVyeXN0cm9uZ3Bhc3N3b3JkLjEwLjI0NC4wLjEK' | base64 -d
kubectl get secret -n safe recipe5 --template={{.data.ingridients}} | base64 -d

kubectl describe secrets db-user-pass
