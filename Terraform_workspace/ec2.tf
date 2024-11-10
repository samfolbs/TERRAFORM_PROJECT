resource "aws_instance" "web-1" {
     ami = "${data.aws_ami.my_ami.id}"
     #ami = "ami-0d857ff0f5fc4e03b"
     availability_zone = "us-west-1a"
     instance_type = "t2.micro"
     key_name = "sam-key"
     subnet_id = "${aws_subnet.subnet1-public.id}"
     vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
     associate_public_ip_address = true	
     tags = {
         Name = "Sam-Server"
         Env = "Prod"
         Owner = "Sam"
 	CostCenter = "ABCD"
     }
      user_data = <<EOF
      #!/bin/bash
      sudo apt-get update
      sudo apt-get install -y nginx
      echo "<h1>${var.env}-Sam-Server</h1>" | sudo tee /var/www/html/index.html
      sudo systemctl start nginx
      sudo systemctl enable nginx
      EOF

 }