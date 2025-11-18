data "aws_iam_policy_document" "eks_assume" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "eks_cluster" {
  name = "AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks" {
  name = "${var.cluster_name}-eks-cluster"

  assume_role_policy = data.aws_iam_policy_document.eks_assume.json

  tags = {
    Name      = "${var.cluster_name}-eks-cluster"
    ManagedBy = "terraform"
    Role      = "eks-cluster"
  }
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = data.aws_iam_policy.eks_cluster.arn

  role = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "eks" {
  name = var.cluster_name

  role_arn = aws_iam_role.eks.arn

  tags = {
    Name      = "${var.cluster_name}-eks-cluster"
    ManagedBy = "terraform"
    Role      = "eks-cluster"
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = var.subnet_ids
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [aws_iam_role_policy_attachment.eks]
}
