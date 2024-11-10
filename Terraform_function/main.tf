#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
    region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "workspace_bucket"
    key    = "function.tfstate"
    region = "us-west-2"
    dynamodb_table = "dynamodb-state-locking"
  }
}


resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_name}"
	    Owner = local.Owner
        CostCenter = local.CostCenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
}


resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"
	tags = {
        Name = "${var.vpc_name}-IGW"
    }
}

resource "aws_route_table" "public-route-table" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }

    tags = {
        Name = "${var.vpc_name}-Public-RT"
        Owner = local.Owner
        CostCenter = local.CostCenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "${var.vpc_name}-Private-RT"
        Owner = local.Owner
        CostCenter = local.CostCenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
}










