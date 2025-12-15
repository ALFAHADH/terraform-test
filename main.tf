provider "aws" {
    region = "us-east-1"
  }

provider "aws" {
    alias = "mumbai"
    region = "ap-south-1"
}

resource "aws_instance" "ec2_us" {
    count = 3
  ami = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
}

resource "aws_instance" "ec2_ap" {

    depends_on = [ aws_s3_bucket.test ]
  provider = aws.mumbai
  ami = "ami-00ca570c1b6d79f36"
  instance_type = "t3.micro"
}

resource "aws_s3_bucket" "test" {
  region = "ap-south-1"
}
