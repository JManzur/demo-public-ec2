
# Classic "Training Course" public EC2 Demo.


## Resources deployed by this manifest:



### Deployment diagram:


![App Screenshot](./public-ec2-demo.png)

## Tested with: 

| Environment | Application | Version  |
| ----------------- |-----------|---------|
| WSL2 Ubuntu 20.04 | Terraform | v1.0.0  |

## Initialization How-To:

Located in the root directory, make an "aws configure" to log into the aws account, and a "terraform init" to download the necessary modules and start the backend.

```bash
aws configure
terraform init
```

## Deployment How-To:

Generate a Key-Pair using AWS-CLI:

```bash
aws ec2 create-key-pair --key-name PublicEC2Demo --query 'KeyMaterial' --output text > PublicEC2Demo.pem
```

>:warning: if you use a different key name, change the variable "key_name" in the variables.tf file

Change permissions:
```bash
chmod 400 PublicEC2Demo.pem
```

Move to home folder:
```bash
mv PublicEC2Demo.pem ~/.ssh/PublicEC2Demo.pem
```

>:warning: if you choose a different location, change the variable "local_ssh_key" in the variables.tf file


## Debugging / Troubleshooting:

#### **Debugging Tip #1**: 

#### **Known issue #1**: 
 - **Issue**: 
- **Cause**: 
- **Solution**: 

## Author:

- [@jmanzur](https://github.com/JManzur)

## Documentation:

- [EXAMPLE](URL)