# Getting started (creating your first bucket)

This project is a template for creating S3 buckets for remote storage of Terraform state.
The buckets created by this project are encrypted, versioning, state locking, public access block,
and prevent accidental deletion.

## 1. Creating a bucket

Comment out the backend block "s3" in the main.tf file.

```bash
 # backend "s3" {
  #   bucket       = "your-bucket-name"
  #   key          = "state-path"
  #   region       = "your-region"
  #   encrypt      = true
  #   use_lockfile = true
  # }
```

## 2. Local initialization

Execute commands:

```bash
terraform init
```

```bash
terraform apply
```

The command will create a bucket in AWS and a local state file on your computer.

## 3. State migration

Uncomment the backend "s3" block

```bash
  backend "s3" {
    bucket       = "your-bucket-nam"
    key          = "state-path"
    region       = "your-region"
    encrypt      = true
    use_lockfile = true
  }
```

Execute the command:

```bash
terraform init
```

Confirm copying the state

## 4. Verification

* Run `terraform state list` to verify remote data fetching.
* Make sure the `terraform.tfstate` file is not in the local directory.

## 5. Remote state is ready to work
