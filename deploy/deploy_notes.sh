kubectl get deploy
kubectl describe deploy deployment-name

kubectl create deployment new-deployment --image nginx:1.19-alpine
kubectl scale deployment new-deployment --replicas=3

kubectl create deployment new-deployment --image nginx --dry-run=client -o yaml > /root/new-deployment.yaml

kubectl set image deployment/nginx *=nginx:1.9.1
kubectl rollout undo deployment/nginx
