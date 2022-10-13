

```bash
minikube start --memory 8192 --cpus 2

helm install airflow chart/ --values chart/values.yaml
```
wait for airflow-webserver to be in running status

```bash
kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
airflow-postgresql-0                 1/1     Running   0          7m6s
airflow-redis-0                      1/1     Running   0          7m6s
airflow-scheduler-7fbd5fdfdd-9lk6c   2/2     Running   0          7m6s
airflow-triggerer-6665f8dcf7-ltqmk   1/1     Running   0          7m6s
airflow-webserver-86c6f6c567-vs7xj   1/1     Running   0          7m6s
airflow-worker-0                     2/2     Running   0          7m6s

```

```bash
kubectl port-forward svc/airflow-webserver 8080:8080 --namespace default

```