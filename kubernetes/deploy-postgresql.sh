helm repo add bitnami https://charts.bitnami.com/bitnami
helm install deeptalk-pg bitnami/postgresql --set postgresqlPassword=deeptalk,postgresqlDatabase=deeptalk
