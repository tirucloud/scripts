## First Create a user in AWS IAM with any name
## Attach Policies to the newly created user
## below policies
AmazonEC2FullAccess

AmazonEKS_CNI_Policy

AmazonEKSClusterPolicy	

AmazonEKSWorkerNodePolicy

AWSCloudFormationFullAccess

IAMFullAccess

#### One more policy we need to create with content as below
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": "*"
        }
    ]
}
```
Attach this policy to your user as well

![Policies To Attach](https://github.com/jaiswaladi246/EKS-Complete/blob/main/Policies.png)

# AWSCLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
aws configure
```

## KUBECTL

```bash
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client
```

## EKSCTL

```bash
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```

## Create EKS CLUSTER

```bash
eksctl create cluster --name=my-eks23 \
                      --region=ap-south-1 \
                      --zones=ap-south-1a,ap-south-1b \
                      --version=1.34 \
                      --without-nodegroup
					  
eksctl utils associate-iam-oidc-provider \
    --region ap-south-1 \
    --cluster my-eks23 \
    --approve
	
eksctl create nodegroup --cluster=my-eks23 \
                       --region=ap-south-1 \
                       --name=node2 \
                       --node-type=t3.small \
                       --nodes=2 \
                       --nodes-min=2 \
                       --nodes-max=3 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=thiru \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access
```

* Open INBOUND TRAFFIC IN ADDITIONAL Security Group
* Create Servcie account/ROLE/BIND-ROLE/Token
## Create namespace webapps
```bash
aws eks update-kubeconfig --region ap-south-1 --name my-eks23
kubectl create namespace webapps
```
## Create Service Account, Role & Assign that role, And create a secret for Service Account and geenrate a Token
### Creating Service Account


```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins
  namespace: webapps
```

### Create Role 
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-role
  namespace: webapps
rules:
  - apiGroups:
        - ""
        - apps
        - autoscaling
        - batch
        - extensions
        - policy
        - rbac.authorization.k8s.io
    resources:
      - pods
      - secrets
      - componentstatuses
      - configmaps
      - daemonsets
      - deployments
      - events
      - endpoints
      - horizontalpodautoscalers
      - ingress
      - jobs
      - limitranges
      - namespaces
      - nodes
      - pods
      - persistentvolumes
      - persistentvolumeclaims
      - resourcequotas
      - replicasets
      - replicationcontrollers
      - serviceaccounts
      - services
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```

### Bind the role to service account


```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: app-rolebinding
  namespace: webapps 
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: app-role 
subjects:
- namespace: webapps 
  kind: ServiceAccount
  name: jenkins 
```

### Generate token using service account in the namespace

[Create Token](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/#:~:text=To%20create%20a%20non%2Dexpiring,with%20that%20generated%20token%20data.)
```bash
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: mysecretname
  annotations:
    kubernetes.io/service-account.name: jenkins
```
```bash
kubectl get rs -n webapps
kubectl get pods -n webapps


kubectl edit rs boardgame-deployment-76b67b74cb -n webapps

kubectl scale deployment boardgame-deployment --replicas=5 -n webapps



kubectl patch svc boardgame-ssvc -n webapps \
  -p '{"spec":{"type":"LoadBalancer"}}'
  
kubectl get svc boardgame-ssvc -n webapps



kubectl get rs -n webapps -o wide
kubectl get rs -n webapps
kubectl scale deployment boardgame-deployment --replicas=2 -n webapps

   86  kubectl get all -n webapps
   87  kubectl delete svc boardgame-ssvc
   88  kubectl apply -f ds.yml
   89  kubectl get all -n webapps
   90  kubectl get svc -n webapps
   91  vi ds.yml
   92  kubectl apply -f ds.yml
   93  kubectl get svc -n webapps
   94  kubectl describe svc boardgame-ssvc -n webapps
   95  vi ds.yml
   96  kubectl apply -f ds.yml
   97  kubectl get svc -n webapps
   98  vi ds.yml
   99  kubectl apply -f ds.yml
  100  kubectl get svc -n webapps
  101  kubectl describe svc boardgame-ssvc -n webapps
  102  kubectl patch svc boardgame-ssvc -n webapps   -p '{"spec":{"type":"LoadBalancer"}}'
  103  kubectl get svc -n webapps


eksctl get clusters
aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE
aws ec2 describe-instances --filters Name=tag:eks:cluster-name,Values=my-eks23

eksctl delete cluster --name my-eks23 --region ap-south-1
```
```
echo cGFzc3dvcmQxMjM= | base64 --decode
```
