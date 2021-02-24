 provider "aws" {
   region = "us-east-1"
   access_key = "AKIAJL3UIWWOXO6GGRFQ"
   secret_key = "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"
 }

# 1. create vpc
# 2. Create Internet gateway
# 3. Create custom route table
# 4. Create a Subnet
# 5. Associate Subnet with route table
# 6. Create Security Group to allow port 443, 80, 22
# 7. Create a network interface with an ip in the subnet that was created in step 4
# 8. Assign an Elastic IP to the network interface crteated in step 7
# 9. Create Windows 2019 AMI and introduce index.html
# 10. Scaling or monitoring?

# 1. create vpc
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "Production"
  }
}

# 2. Create Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id


}
# 3. Create custom route table

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod"
  }
}