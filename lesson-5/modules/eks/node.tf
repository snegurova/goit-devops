data "aws_iam_policy_document" "eks_node_assume" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "amazon_eks_worker_node_policy" {
  name = "AmazonEKSWorkerNodePolicy"
}

data "aws_iam_policy" "amazon_eks_cni_policy" {
  name = "AmazonEKS_CNI_Policy"
}

data "aws_iam_policy" "amazon_ec2_container_registry_read_only" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role" "nodes" {
  name = "${var.cluster_name}-eks-nodes"

  assume_role_policy = data.aws_iam_policy_document.eks_node_assume.json


  tags = {
    Name = "${var.cluster_name}-eks-nodes"
    Role = "eks-nodes"
  }
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = data.aws_iam_policy.amazon_eks_worker_node_policy.arn
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = data.aws_iam_policy.amazon_eks_cni_policy.arn
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = data.aws_iam_policy.amazon_ec2_container_registry_read_only.arn
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "general" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "general"

  node_role_arn = aws_iam_role.nodes.arn

  subnet_ids = var.subnet_ids

  capacity_type  = "ON_DEMAND"
  instance_types = ["${var.instance_type}"]

  tags = {
    Name      = "${var.cluster_name}-nodegroup-general"
    Role      = "eks-nodes"
    NodeGroup = "general"
  }

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}

