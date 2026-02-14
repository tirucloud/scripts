    1  helm repo add bitnami https://charts.bitnami.com/bitnami
    2  helm list
    3  helm list repo
    4  helm repo list
    5  Deploy the Apache application on the cluster using the apache from the bitnami repository.
    6  Set the release Name to: amaze-surf
    7  helm repo add bitnami https://charts.bitnami.com/bitnami
    8  helm repo update
    9  helm install amaze-surf bitnami/apache
   10  helm list
   11  kubectl get pod
   12  kubectl get svc
   13  kubectl port-forward svc/amaze-surf-apache 8080:80
   14  kubectl get svc amaze-surf-apache
   15  helm list
   16  helm list releases
   17  helm repo list
   18  helm list
   19  helm list -A
   20  helm uninstall happy-browse
   21  helm list -A
   22  Remove the Hashicorp helm repository from the cluster.
   23  helm repo remove hashicorp
