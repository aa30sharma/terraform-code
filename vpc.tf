resource "aws_vpc" "my-vpc" {

  cidr_block       = "10.0.0.0/16"

  instance_tenancy = "default"

  enable_dns_support = "true"

  enable_dns_hostnames = "true"

 



  tags = {

    Name = "my-vpc"

  }

}



data "aws_availability_zones" "available" {

  state = "available"

}



resource "aws_subnet" "public_subnet1" {

  vpc_id     = aws_vpc.my-vpc.id

  cidr_block = "10.0.1.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  map_public_ip_on_launch = "true"



  tags = {

    Name = "public_subnet1"

  }

}



resource "aws_subnet" "public_subnet2" {

  vpc_id     = aws_vpc.my-vpc.id

  cidr_block = "10.0.2.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

  map_public_ip_on_launch = "true"



  tags = {

    Name = "public_subnet2"

  }

}



resource "aws_subnet" "private_subnet1" {

  vpc_id     = aws_vpc.my-vpc.id

  cidr_block = "10.0.3.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  



  tags = {

    Name = "private_subnet1"

  }

}



resource "aws_subnet" "private_subnet2" {

  vpc_id     = aws_vpc.my-vpc.id

  cidr_block = "10.0.4.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

  



  tags = {

    Name = "private_subnet2"

  }

}



resource "aws_subnet" "RDS_subnet1" {

  vpc_id     = aws_vpc.my-vpc.id

  cidr_block = "10.0.5.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]





  tags = {

    Name = "RDS_subnet1"

  }

}



resource "aws_subnet" "RDS_subnet2" {

  vpc_id     = aws_vpc.my-vpc.id

  cidr_block = "10.0.6.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

 



  tags = {

    Name = "RDS_subnet2"

  }

}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.my-vpc.id



  tags = {

    Name = "vpc-igw"

  }

}



resource "aws_route_table" "route1" {

  vpc_id = aws_vpc.my-vpc.id



  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }



  tags = {

    Name = "subnet1-route"

  }

}



resource "aws_route_table" "route2" {

  vpc_id = aws_vpc.my-vpc.id



  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }



  tags = {

    Name = "subnet2-route"

  }

}



resource "aws_route_table_association" "associate-route1" {

  subnet_id      = aws_subnet.public_subnet1.id

  route_table_id = aws_route_table.route1.id

}



resource "aws_route_table_association" "associate-route2" {

  subnet_id      = aws_subnet.public_subnet2.id

  route_table_id = aws_route_table.route2.id

}

