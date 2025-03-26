
variable "ec2module" {
  type = string
}

resource "aws_instance" "name" {
    ami = "ami-08b5b3a93ed654d19"
    instance_type = "t2.micro"
    tags = {
      Name = "var.ec2name"
    }
}
