resource "aws_instance" "server" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    vpc_security_group_ids = [ aws_security_group.grupo_seguridad.id ]
    key_name = "${var.key}"
    tags = {
      "Name" = "${var.app}-ec2-${var.env}"
      "Infra" = "Terraform"
      "Owner" = "DevOps Team"
    }
    user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install docker git -y
sudo service docker start
sudo usermod -a -G docker ec2-user 
DC_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/docker/compose/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/$DC_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo service docker restart
EOF
}