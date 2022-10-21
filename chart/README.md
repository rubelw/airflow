
Based on: http://marclamberti.com/blog/airflow-kubernetes-executor/

 minikube start --kubernetes-version=v1.23.0 --memory 20000 --cpus 3

cd airflow/scripts/ci/kubernetes/
./docker/build.sh 

update compile.sh to node 12

curl -sL https://deb.nodesource.com/setup_12.x | bash -

use kubectl conver -f file to convert old templates

./kube/deploy.sh -d persistent_mode



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

If you need Celery executor for flower

```bash
helm install airflow chart/ --values chart/values.yaml  --set executor=CeleryExecutor --set workers.persistence.size=1Gi

or 

helm install airflow chart/ --values chart/values.yaml  --set executor=CeleryKubernetesExecutor --set workers.persistence.size=1Gi

```

 ldapsearch -x -W -d 1 -h ldap-service -p 389 -b "cn=admin,dc=example,dc=org" -D "dc=example,dc=org"


