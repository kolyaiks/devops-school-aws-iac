# Final AWS task for DevOps school
Terraform script of this repo is intended to spin up the infrastructure described below.
![Alt text](infra.png?raw=true)
You must have an access key and secret key for the user with appropriate rights.
Use the command below to set environment variables before launching Terraform script:
```
export AWS_ACCESS_KEY_ID=your_access_key \
export AWS_SECRET_ACCESS_KEY=your_secret_key \
export AWS_DEFAULT_REGION=your_region
```
You must have existing key pair too. You have to set the name of this key pair as a value for the ssh_key_name variable in the optional.tfvars file.
Finally, you can run the command below to spin up infrastructure:
```
terraform apply -var-file=optional.tfvars
```
You'll get the alb_dns variable as the output of this script, and this is the DNS name of the ALB. You can use the value of this variable to access WordPress.
