provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-08b5b3a93ed654d19"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.sg.name ]
    tags = {
      Name = "CreatedByTerraform"
    }
}

variable "ingressIP" {
  type = list(number)
  default = [ 80,443,22 ]
}

variable "egressIP" {
  type = list(number)
  default = [ 80,443 ]
}

resource "aws_security_group" "sg" {
    name = "allow https"

    dynamic "ingress" {
      for_each = var.ingressIP
      content {
        description      = "Allow traffic on port"
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
      }
    }

    dynamic "egress" {
      for_each = var.egressIP
      content {
        description      = "Allow traffic on port"
        from_port        = egress.value
        to_port          = egress.value
        protocol         = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
      }
    }
}


