# AWS EKS Cluster installation with Fargate and EC2 worker nodes in existing VPC with terraform templates

- This is basic installation of AWS EKS Cluster with fargate and Worker Nodes
- Assumes you have AWS Secret [Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) Setup
- You need to have VPC, Subnets and Security Groups details
- Make sure you have adequate Ip's available within your subnets
- Update Kubernetes Config Map to provide access to additional users, refer this. You can also use terraform [modules](https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/examples/basic/main.tf) to automate it
