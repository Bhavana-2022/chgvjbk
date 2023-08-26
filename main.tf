resource "aws_vpc" "itsmyvpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "itsmyvpc"
  }
}


resource "aws_subnet" "sub" {
  count             = length(var.name)
  vpc_id            = aws_vpc.itsmyvpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = var.availabilityzone[count.index]


  tags = {
    Name = var.name[count.index]
  }
}



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.itsmyvpc.id

  tags = {
    Name = "internetgateway"
  }
  depends_on = [aws_vpc.itsmyvpc]
}


data "aws_route_table" "default" {
  vpc_id = aws_vpc.itsmyvpc.id

  depends_on = [aws_vpc.itsmyvpc]
}


resource "aws_route" "route" {
  route_table_id         = data.aws_route_table.default.id
  destination_cidr_block = local.towhere
  gateway_id             = aws_internet_gateway.gw.id

  depends_on = [aws_vpc.itsmyvpc, aws_internet_gateway.gw]
}
