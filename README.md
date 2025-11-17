# Terraform — AWS Infrastructure

This project demonstrates how to build AWS infrastructure using Terraform
modules. It includes an S3 backend with lock state, a VPC with public and
private subnets, and an ECR repository for container images with scan on push.

---

## 📘 Project Structure

```
lesson-5/
│
├── main.tf             # Connects all modules
├── backend.tf          # Terraform backend configuration (S3)
├── outputs.tf          # Global outputs
│
├── modules/
│   ├── vpc/            # VPC, subnets, IGW, NAT, routing
│   ├── ecr/            # ECR repository and IAM policy
│
├── s3-backend-bootstrap/     # S3 bucket for Terraform state
│
└── README.md
```

---

## 🚀 Terraform Commands

### Initialize Terraform

```
terraform init
```

### Show execution plan

```
terraform plan
```

### Apply infrastructure

```
terraform apply
```

### Destroy all resources

```
terraform destroy
```

---

## 🔧 Set up

Set AWS profile

```bash
export AWS_PROFILE=
```

Move to project dir

```bash
cd lesson-5
```

---

## 📌 Module and Project Explanations

### 🟦 Project: s3-backend-bootstrap

This project configures Terraform's remote state storage:

- Creates an S3 bucket for storing the terraform.tfstate file
- Enables versioning to preserve state history
- Enables state locking

**Outputs:**

- s3_bucket_name

### Create backend bucket

```bash
cd s3-backend-bootstrap/
terraform init
```

Check planned changes

```bash
terraform plan
```

Apply changes to create bucket

```bash
terraform apply
```

Destroy bucket if needed

```bash
terraform destroy
```

Return back to root terraform project folder

```bash
cd ..
```

---

---

### 🟩 Module: vpc

This module provisions networking infrastructure:

- A VPC using a provided CIDR block
- Three public subnets
- Three private subnets
- Internet Gateway for public subnets
- NAT Gateway for private subnets
- Route tables and routing

**Outputs:**

- vpc_id
- public_subnets
- private_subnets
- internet_gateway_id

---

### 🟧 Module: ecr

This module creates a private ECR repository:

- ECR repository for Docker images
- Automatic image scanning on push
- IAM policy allowing full access within the AWS account

**Outputs:**

- repository_url
- repository_arn

---

## Manage project

Initialize project (make sure you are in the lesson-5)

```bash
terraform init
```

Check planned changes

```bash
terraform plan
```

Apply changes to create resources

```bash
terraform apply
```

Destroy resources if needed

```bash
terraform destroy
```

---

## ✅ Summary

This Terraform project demonstrates:

- Remote backend configuration via S3
- Modular infrastructure design
- Building networking layers (VPC, subnets, routing)
- Creating an ECR repository with proper IAM access

You can now extend this setup by adding EC2 instances, ECS, or other AWS
services.
