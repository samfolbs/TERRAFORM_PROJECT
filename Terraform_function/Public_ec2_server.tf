resource "aws_instance" "public-server" {
     #ami = "${data.aws_ami.my_ami.id}"
     #count = "${lenght(var.public_cird_block)}"
     count = "${var.environment == "Prod" ? 3:1}"
     ami = "${lookup(var.amis, var.aws_region)}"           # "ami-0d857ff0f5fc4e03b"
     #availability_zone = "us-west-2a"
     instance_type = "t2.micro"
     key_name = var.key_name
     subnet_id = "${element(aws_subnet.public-subnet.*.id, count.index+1)}"
     vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
     associate_public_ip_address = true	
     tags = {
        Name = "${var.vpc_name}_Public-server-${count.index+1}"
	     Owner = local.Owner
        CostCenter = local.CostCenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
     }
      
}