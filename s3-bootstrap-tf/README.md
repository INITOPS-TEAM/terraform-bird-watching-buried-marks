# Getting started (creating your first bucket)

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

## 4. Remote state is ready to work
