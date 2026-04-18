# Getting started

## 1. Installing Terraform

Install Terraform using one of the methods following the instructions
from the official website:
<https://developer.hashicorp.com/terraform/install>

## 2. Installing AWS CLI

To interact with AWS, install AWS CLI:
<https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>

## 3. Configuring access

After installing the tools, configure access to your account.

**Configure credentials:**

```bash
aws configure --profile my-project-profile
```

**Enter your data:**

- AWS Access Key ID: Your ID
- AWS Secret Access Key: Your Secret Key
- Default region name: eu-north-1
- Default output format: json

### AWS profile activation

```bash
# Linux / macOS / Git Bash
export AWS_PROFILE=my-project-profile

# PowerShell (Windows)
$env:AWS_PROFILE = "my-project-profile"

# CMD (Windows)
set AWS_PROFILE=my-project-profile
```

**Check the connection to AWS:**

```bash
aws sts get-caller-identity
```

## 4. Starting the project

***Pre-requisites (Important)***

Before running Terraform, you must ensure that a Route 53 Hosted Zone
exists in your AWS account for your environment.

***For Dev:*** Create a public hosted zone named dev.domen.name

***For Stage:*** Create a public hosted zone named stage.domen.name

***For Prod:*** Create a public hosted zone named prod.domen.name

Note: After creating the zone, ensure its Name Servers (NS) are updated at your domain registrar

### Running Terraform

```bash
terraform init
terraform plan
terraform apply
```

### RDS

For enabling RDS IAM authentication, it is needed to add target user to the following PostgreSQL group:

```sql
GRANT rds_iam TO <database_user>;
```

### Consul Service Mesh

#### Access Consul UI

Forward the Consul server port:

```bash
kubectl port-forward pod/consul-server-0 -n consul 8500:8500
```

Then open your browser: `http://localhost:8500`

#### Get Bootstrap ACL Token

To authenticate in Consul UI, retrieve the bootstrap ACL token:

```bash
kubectl get secret consul-bootstrap-acl-token -n consul -o jsonpath="{.data.token}" | base64 --decode
```
