output "cluster_name" {
  value = "k8s.damdam.me"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-k8s-damdam-me.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-k8s-damdam-me.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-k8s-damdam-me.name}"
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-k8s-damdam-me.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-1a-k8s-damdam-me.id}", "${aws_subnet.us-east-1b-k8s-damdam-me.id}", "${aws_subnet.us-east-1c-k8s-damdam-me.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-k8s-damdam-me.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-k8s-damdam-me.name}"
}

output "region" {
  value = "us-east-1"
}

output "vpc_id" {
  value = "${aws_vpc.k8s-damdam-me.id}"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-k8s-damdam-me" {
  name                 = "master-us-east-1a.masters.k8s.damdam.me"
  launch_configuration = "${aws_launch_configuration.master-us-east-1a-masters-k8s-damdam-me.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-k8s-damdam-me.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1a.masters.k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-east-1b-masters-k8s-damdam-me" {
  name                 = "master-us-east-1b.masters.k8s.damdam.me"
  launch_configuration = "${aws_launch_configuration.master-us-east-1b-masters-k8s-damdam-me.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1b-k8s-damdam-me.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1b.masters.k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1b"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-east-1c-masters-k8s-damdam-me" {
  name                 = "master-us-east-1c.masters.k8s.damdam.me"
  launch_configuration = "${aws_launch_configuration.master-us-east-1c-masters-k8s-damdam-me.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1c-k8s-damdam-me.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1c.masters.k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1c"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-k8s-damdam-me" {
  name                 = "nodes.k8s.damdam.me"
  launch_configuration = "${aws_launch_configuration.nodes-k8s-damdam-me.id}"
  max_size             = 3
  min_size             = 3
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-k8s-damdam-me.id}", "${aws_subnet.us-east-1b-k8s-damdam-me.id}", "${aws_subnet.us-east-1c-k8s-damdam-me.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.k8s.damdam.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-k8s-damdam-me" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "a.etcd-events.k8s.damdam.me"
    "k8s.io/etcd/events"                  = "a/a,b,c"
    "k8s.io/role/master"                  = "1"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-k8s-damdam-me" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "a.etcd-main.k8s.damdam.me"
    "k8s.io/etcd/main"                    = "a/a,b,c"
    "k8s.io/role/master"                  = "1"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-events-k8s-damdam-me" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "b.etcd-events.k8s.damdam.me"
    "k8s.io/etcd/events"                  = "b/a,b,c"
    "k8s.io/role/master"                  = "1"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-main-k8s-damdam-me" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "b.etcd-main.k8s.damdam.me"
    "k8s.io/etcd/main"                    = "b/a,b,c"
    "k8s.io/role/master"                  = "1"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-events-k8s-damdam-me" {
  availability_zone = "us-east-1c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "c.etcd-events.k8s.damdam.me"
    "k8s.io/etcd/events"                  = "c/a,b,c"
    "k8s.io/role/master"                  = "1"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-main-k8s-damdam-me" {
  availability_zone = "us-east-1c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "c.etcd-main.k8s.damdam.me"
    "k8s.io/etcd/main"                    = "c/a,b,c"
    "k8s.io/role/master"                  = "1"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-k8s-damdam-me" {
  name = "masters.k8s.damdam.me"
  role = "${aws_iam_role.masters-k8s-damdam-me.name}"
}

resource "aws_iam_instance_profile" "nodes-k8s-damdam-me" {
  name = "nodes.k8s.damdam.me"
  role = "${aws_iam_role.nodes-k8s-damdam-me.name}"
}

resource "aws_iam_role" "masters-k8s-damdam-me" {
  name               = "masters.k8s.damdam.me"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.k8s.damdam.me_policy")}"
}

resource "aws_iam_role" "nodes-k8s-damdam-me" {
  name               = "nodes.k8s.damdam.me"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.k8s.damdam.me_policy")}"
}

resource "aws_iam_role_policy" "masters-k8s-damdam-me" {
  name   = "masters.k8s.damdam.me"
  role   = "${aws_iam_role.masters-k8s-damdam-me.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.k8s.damdam.me_policy")}"
}

resource "aws_iam_role_policy" "nodes-k8s-damdam-me" {
  name   = "nodes.k8s.damdam.me"
  role   = "${aws_iam_role.nodes-k8s-damdam-me.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.k8s.damdam.me_policy")}"
}

resource "aws_internet_gateway" "k8s-damdam-me" {
  vpc_id = "${aws_vpc.k8s-damdam-me.id}"

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "k8s.damdam.me"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-k8s-damdam-me-d4df478bfe2eb39c343492354b690f7a" {
  key_name   = "kubernetes.k8s.damdam.me-d4:df:47:8b:fe:2e:b3:9c:34:34:92:35:4b:69:0f:7a"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.k8s.damdam.me-d4df478bfe2eb39c343492354b690f7a_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1a-masters-k8s-damdam-me" {
  name_prefix                 = "master-us-east-1a.masters.k8s.damdam.me-"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "m3.medium"
  key_name                    = "${aws_key_pair.kubernetes-k8s-damdam-me-d4df478bfe2eb39c343492354b690f7a.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-k8s-damdam-me.id}"
  security_groups             = ["${aws_security_group.masters-k8s-damdam-me.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.k8s.damdam.me_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  ephemeral_block_device = {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral0"
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-east-1b-masters-k8s-damdam-me" {
  name_prefix                 = "master-us-east-1b.masters.k8s.damdam.me-"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "m3.medium"
  key_name                    = "${aws_key_pair.kubernetes-k8s-damdam-me-d4df478bfe2eb39c343492354b690f7a.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-k8s-damdam-me.id}"
  security_groups             = ["${aws_security_group.masters-k8s-damdam-me.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1b.masters.k8s.damdam.me_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  ephemeral_block_device = {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral0"
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-east-1c-masters-k8s-damdam-me" {
  name_prefix                 = "master-us-east-1c.masters.k8s.damdam.me-"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "m3.medium"
  key_name                    = "${aws_key_pair.kubernetes-k8s-damdam-me-d4df478bfe2eb39c343492354b690f7a.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-k8s-damdam-me.id}"
  security_groups             = ["${aws_security_group.masters-k8s-damdam-me.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1c.masters.k8s.damdam.me_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  ephemeral_block_device = {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral0"
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-k8s-damdam-me" {
  name_prefix                 = "nodes.k8s.damdam.me-"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-k8s-damdam-me-d4df478bfe2eb39c343492354b690f7a.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-k8s-damdam-me.id}"
  security_groups             = ["${aws_security_group.nodes-k8s-damdam-me.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.k8s.damdam.me_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.k8s-damdam-me.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.k8s-damdam-me.id}"
}

resource "aws_route_table" "k8s-damdam-me" {
  vpc_id = "${aws_vpc.k8s-damdam-me.id}"

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "k8s.damdam.me"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
    "kubernetes.io/kops/role"             = "public"
  }
}

resource "aws_route_table_association" "us-east-1a-k8s-damdam-me" {
  subnet_id      = "${aws_subnet.us-east-1a-k8s-damdam-me.id}"
  route_table_id = "${aws_route_table.k8s-damdam-me.id}"
}

resource "aws_route_table_association" "us-east-1b-k8s-damdam-me" {
  subnet_id      = "${aws_subnet.us-east-1b-k8s-damdam-me.id}"
  route_table_id = "${aws_route_table.k8s-damdam-me.id}"
}

resource "aws_route_table_association" "us-east-1c-k8s-damdam-me" {
  subnet_id      = "${aws_subnet.us-east-1c-k8s-damdam-me.id}"
  route_table_id = "${aws_route_table.k8s-damdam-me.id}"
}

resource "aws_security_group" "masters-k8s-damdam-me" {
  name        = "masters.k8s.damdam.me"
  vpc_id      = "${aws_vpc.k8s-damdam-me.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "masters.k8s.damdam.me"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_security_group" "nodes-k8s-damdam-me" {
  name        = "nodes.k8s.damdam.me"
  vpc_id      = "${aws_vpc.k8s-damdam-me.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "nodes.k8s.damdam.me"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-damdam-me.id}"
  source_security_group_id = "${aws_security_group.masters-k8s-damdam-me.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-k8s-damdam-me.id}"
  source_security_group_id = "${aws_security_group.masters-k8s-damdam-me.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-k8s-damdam-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-damdam-me.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-k8s-damdam-me.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-k8s-damdam-me.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-k8s-damdam-me.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-damdam-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-damdam-me.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-damdam-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-damdam-me.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-damdam-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-damdam-me.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-damdam-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-damdam-me.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-k8s-damdam-me.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-k8s-damdam-me.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-1a-k8s-damdam-me" {
  vpc_id            = "${aws_vpc.k8s-damdam-me.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-1a"

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "us-east-1a.k8s.damdam.me"
    SubnetType                            = "Public"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
    "kubernetes.io/role/elb"              = "1"
  }
}

resource "aws_subnet" "us-east-1b-k8s-damdam-me" {
  vpc_id            = "${aws_vpc.k8s-damdam-me.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "us-east-1b"

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "us-east-1b.k8s.damdam.me"
    SubnetType                            = "Public"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
    "kubernetes.io/role/elb"              = "1"
  }
}

resource "aws_subnet" "us-east-1c-k8s-damdam-me" {
  vpc_id            = "${aws_vpc.k8s-damdam-me.id}"
  cidr_block        = "172.20.96.0/19"
  availability_zone = "us-east-1c"

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "us-east-1c.k8s.damdam.me"
    SubnetType                            = "Public"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
    "kubernetes.io/role/elb"              = "1"
  }
}

resource "aws_vpc" "k8s-damdam-me" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "k8s.damdam.me"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "k8s-damdam-me" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                     = "k8s.damdam.me"
    Name                                  = "k8s.damdam.me"
    "kubernetes.io/cluster/k8s.damdam.me" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "k8s-damdam-me" {
  vpc_id          = "${aws_vpc.k8s-damdam-me.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.k8s-damdam-me.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
