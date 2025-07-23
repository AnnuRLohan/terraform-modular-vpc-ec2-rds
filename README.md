# Terraform AWS Modular VPC with Public/Private EC2 and RDS

## 📘 Overview

This project creates a modular and production-style AWS VPC using Terraform. It provisions:
- A custom VPC with public and private subnets across **multiple AZs**
- EC2 instances in both **public** and **private** subnets
- An **RDS MySQL** database inside private subnets
- Secure access to private EC2 via **Bastion Host** and to RDS via **security groups**
- Remote backend using **S3 + DynamoDB** (optional)

## 🛠 Tools & Services Used

- Terraform
- AWS VPC, Subnets, Route Tables, IGW, NAT Gateway
- EC2 Instances (Amazon Linux 2)
- RDS (MySQL)
- S3 + DynamoDB (for remote backend)
- SSH Key Pair
- Visual Studio Code

## 📁 Project Structure

```
terraform-modular-vpc-ec2-rds/
├── modules/
│   ├── vpc/
│   ├── ec2-public/
│   ├── ec2-private/
│   └── rds/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── terraform.tfvars
└── .gitignore
```

## ⚙️ Features

- **VPC**: `10.0.0.0/16`
- **Public Subnet**: `10.0.1.0/24` in AZ `us-east-1a`
- **Private Subnets**: `10.0.2.0/24`, `10.0.3.0/24` in AZs `us-east-1a`, `us-east-1b`
- **EC2 Public**: Accessible via internet using SSH
- **EC2 Private**: Accessible via Bastion (public EC2)
- **RDS MySQL**: Deployed in private subnets, not publicly accessible
- **Security Groups**: Fine-grained access control for all resources

## 🚀 How to Use

### 1. Clone the Repo
```bash
git clone https://github.com/YOUR_USERNAME/terraform-modular-vpc-ec2-rds.git
cd terraform-modular-vpc-ec2-rds
```

### 2. Configure AWS CLI (once per machine)
```bash
aws configure
```

### 3. Create S3 & DynamoDB for Remote Backend (optional)
```bash
aws s3api create-bucket --bucket <your-bucket-name> --region us-east-1
aws dynamodb create-table --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST --region us-east-1
```

### 4. Initialize and Apply
```bash
terraform init
terraform plan
terraform apply
```

## 🔐 Accessing Private EC2 and RDS

- Use Bastion EC2 to SSH into private EC2:
```bash
ssh -i ~/.ssh/terraform-key ec2-user@<public-ec2-ip>
```

- Then SSH to private EC2 from inside:
```bash
ssh -i terraform-key ec2-user@<private-ec2-ip>
```

- RDS can be accessed using a MySQL client inside private EC2:
```bash
mysql -h <rds-endpoint> -u <db-username> -p
```

## 🧼 Cleanup

To destroy resources:
```bash
terraform destroy
```

To remove backend storage:
```bash
aws s3 rb s3://<your-bucket-name> --force
aws dynamodb delete-table --table-name terraform-locks
```

## 📌 Author

Annu Lohan - [LinkedIn](www.linkedin.com/in/annu-rani-lohan-069146ba)

## 📜 License

This project is open-source and free to use.
