resource "aws_security_group" "websec" {
  name        = var.websecurityrule.name
  description = var.websecurityrule.description
  vpc_id      = aws_vpc.itsmyvpc.id

  tags = {
    Name = "this is ours"
  }


}


resource "aws_security_group_rule" "websecrule" {
  count             = length(var.websecurityrule.rules)
  type              = var.websecurityrule.rules[count.index].type
  from_port         = var.websecurityrule.rules[count.index].from_port
  to_port           = var.websecurityrule.rules[count.index].to_port
  protocol          = var.websecurityrule.rules[count.index].protocol
  cidr_blocks       = [var.websecurityrule.rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.websec.id
}


resource "aws_security_group" "appsec" {
  name        = var.appsecurityrule.name
  description = var.appsecurityrule.description
  vpc_id      = aws_vpc.itsmyvpc.id

  tags = {
    Name = "this is ours"
  }


}


resource "aws_security_group_rule" "appsecrule" {
  count             = length(var.appsecurityrule.rules)
  type              = var.appsecurityrule.rules[count.index].type
  from_port         = var.appsecurityrule.rules[count.index].from_port
  to_port           = var.appsecurityrule.rules[count.index].to_port
  protocol          = var.appsecurityrule.rules[count.index].protocol
  cidr_blocks       = [var.appsecurityrule.rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.appsec.id
}



resource "aws_security_group" "dbsec" {
  name        = var.dbsecurityrule.name
  description = var.dbsecurityrule.description
  vpc_id      = aws_vpc.itsmyvpc.id

  tags = {
    Name = "this is ours"
  }


}


resource "aws_security_group_rule" "dbsecrule" {
  count             = length(var.dbsecurityrule.rules)
  type              = var.dbsecurityrule.rules[count.index].type
  from_port         = var.dbsecurityrule.rules[count.index].from_port
  to_port           = var.dbsecurityrule.rules[count.index].to_port
  protocol          = var.dbsecurityrule.rules[count.index].protocol
  cidr_blocks       = [var.dbsecurityrule.rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.dbsec.id
}


