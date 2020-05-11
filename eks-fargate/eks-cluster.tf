resource "aws_iam_role" "example-eks-fargate-cluster" {
  name = "example-eks-fargate-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example-eks-fargate-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.example-eks-fargate-cluster.name
}

resource "aws_iam_role_policy_attachment" "example-eks-fargate-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.example-eks-fargate-cluster.name
}

resource "aws_eks_cluster" "example-eks-fargate-cluster" {
  name     = "example-eks-fargate-cluster"
  role_arn = aws_iam_role.example-eks-fargate-cluster.arn
  version  = "1.16"
  vpc_config {
    security_group_ids = [
      "sg-1234",
      "sg-5678",
    ]
    subnet_ids = [
      "subnet-1234",
      "subnet-5678",
    ]
  }
  timeouts {
    create = "4h"
    delete = "4h"
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-eks-fargate-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-eks-fargate-cluster-AmazonEKSServicePolicy,
  ]

}
