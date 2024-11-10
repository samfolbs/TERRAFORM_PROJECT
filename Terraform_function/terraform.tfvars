aws_region = "us-west-2"
vpc_cidr = "172.18.0.0/16"
vpc_name = "Sam_VPC "
key_name = "sam_key"
azs = ["us-west-2a", "us-west-2b", "us-west-2c"]
public_cird_block = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
private_cird_block = ["172.18.10.0/24", "172.18.20.0/24", "172.18.30.0/24"]
environment = "Prod"
ingress_value = ["80","8080","443","8443","22","3306","1900","1443"]
amis = {
    us-west-1 = "ami-13242627"
    us-west-2 = "ami-42433955"
}