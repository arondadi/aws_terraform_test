provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] #Canonical, ubuntu publisher

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_configuration" "terraform-test-launch-config" {
  name          = "terraform-test-launch-config"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t3.micro"


  key_name        = "${var.key_name}"
  security_groups = ["${var.sec_group}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ASG_terraform_test" {
  name               = "ASG-terraform-test"
  availability_zones = ["eu-west-1b", "eu-west-1c"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1

  launch_configuration = "${aws_launch_configuration.terraform-test-launch-config.name}"

  lifecycle {
    create_before_destroy = true
  }
}
