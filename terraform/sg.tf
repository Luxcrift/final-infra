# Definir grupo de seguridad puerto 80 servidores
resource "aws_security_group" "grupo_seguridad" {
    name = "${var.app}-${var.env}-sg"
    vpc_id = data.aws_vpc.default.id

    ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso al puerto 80"
      from_port = 80
      to_port = 80
      protocol = "TCP"
    } 
    ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso al puerto 22"
      from_port = 22
      to_port = 22
      protocol = "TCP"
    } 
    ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso al puerto de la app"
      from_port = 3000
      to_port = 3002
      protocol = "TCP"
    } 
    ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso al puerto de la app"
      from_port = 443
      to_port = 443
      protocol = "TCP"
    }

    egress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "All trafic"
      from_port = 0
      to_port = 0
      protocol = "-1"
    } 
}