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

### Running Terraform

```bash
terraform init
terraform plan
terraform apply
```
