
variable "awsamiid" {
  type    = string
  default = "ami-024e6efaf93d85776"

}


variable "awsinstancetype" {
  type    = string
  default = "t2.medium"

}






variable "name" {
  type    = list(string)
  default = ["web", "db1", "db2"]

}
variable "availabilityzone" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]



}

variable "subnetgroup" {
  type    = list(string)
  default = ["db1", "db2"]

}


variable "aws_key_pair" {
  type    = string
  default = "~/.ssh/id_rsa.pub"

}

variable "privatekey" {
  type    = string
  default = "~/.ssh/id_rsa"

}


variable "web" {
  type    = string
  default = "web"

}



variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}

variable "websecurityrule" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type        = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = string
    }))
  })
  default = {
    name        = "websecurity"
    description = "this is security"
    rules = [{
      type        = "ingress"
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "ingress"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "egress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      }
    ]
  }


}
variable "appsecurityrule" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type        = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = string
    }))
  })
  default = {
    name        = "appsecurity"
    description = "this is security"
    rules = [{
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "ingress"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "egress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      }
    ]
  }


}
variable "dbsecurityrule" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type        = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = string
    }))
  })
  default = {
    name        = "dbsecurity"
    description = "this is security"
    rules = [{
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "egress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      }
    ]
  }


}