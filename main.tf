provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default_vpc" {
  default = true
}

#data "aws_subnet" "default_subnet" {
#    default_for_az = true
#}

resource "aws_instance" "InstaciaDevOps" {
    ami = "ami-084568db4383264d4" # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
    instance_type = "t2.micro"
    key_name = "par_de_claves_devops"
    security_groups = [ aws_security_group.GrupoSeguridad_devops.id ]
    subnet_id = "subnet-07a51637793094fc1"
    tags = {
        Name = "InstaciaDevOps"
    }
    associate_public_ip_address = true
}

resource "aws_security_group" "GrupoSeguridad_devops" {
    name        = "GrupoSeguridad"
    description = "Grupo de seguridad para InstaciaDevOps"
    vpc_id      = data.aws_vpc.default_vpc.id

    tags = {
        Name = "GrupoSeguridad"
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}