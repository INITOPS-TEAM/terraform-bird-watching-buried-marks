
## Dev Environment

## 🚀 Quick Start

Run all the commands described in the readme in the dev folder of the environment.

```bash
terraform init
terraform apply
```

## 🔄 Daily Workflow

### Launch

```bash
terraform apply
```

### Destroy

```bash
./destroy.sh
```

Destroys EC2 instances and NAT Gateway. Keeps Jenkins data volume, VPC, IAM, S3, DNS.

## 🎩 Jenkins

Jenkins is raised together with the DEV environment `terraform apply`.
After the first apply, it is configured manually.

**To stop Jenkins** (preserves all pipelines and settings):
AWS Console ➜ EC2 ➜ Instances ➜ birdmarks-dev-jenkins ➜ Instance State ➜  Stop

**To start Jenkins:**
AWS Console ➜  EC2 ➜  Instances ➜  birdmarks-dev-jenkins ➜  Instance State ➜  Start

❗️ Jenkins data volume has `prevent_destroy` — running `terraform destroy`
without the script will fail safely and nothing will be deleted.
