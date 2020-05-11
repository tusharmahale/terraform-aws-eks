resource "aws_eks_fargate_profile" "example-eks-fargate-cluster-coredns" {
  cluster_name           = aws_eks_cluster.example-eks-fargate-cluster.name
  fargate_profile_name   = "example-eks-fargate-cluster-coredns"
  pod_execution_role_arn = aws_iam_role.example-eks-fargate-cluster-pods.arn
  subnet_ids             = ["subnet-1234",]

  selector {
    namespace = "kube-system"
    labels = {
                "k8s-app": "kube-dns"
           }
  }
}

resource "aws_eks_fargate_profile" "example-eks-fargate-cluster-default" {
  cluster_name           = aws_eks_cluster.example-eks-fargate-cluster.name
  fargate_profile_name   = "example-eks-fargate-cluster-default"
  pod_execution_role_arn = aws_iam_role.example-eks-fargate-cluster-pods.arn
  subnet_ids             = ["subnet-1234",]

  selector {
    namespace = "default"
  }
}

resource "aws_iam_role" "example-eks-fargate-cluster-pods" {
  name = "example-eks-fargate-cluster-pods"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-eks-fargate-cluster-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.example-eks-fargate-cluster-pods.name
}
