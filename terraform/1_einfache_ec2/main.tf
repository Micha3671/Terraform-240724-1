# Dies ist ein Kommentar

# Provider-Definition (Mindestanforderung für "terraform init")
provider "aws" {
  region = "eu-central-1"
}

# Eine Ubuntu EC2 Instanz im kleinen t2.nano-Format
resource "aws_instance" "erste_instanz" {
  instance_type = "t2.nano"
  ami = "ami-01e444924a2233b07"
  vpc_security_group_ids = [ "sg-09159bd49e5ad69e9", "sg-0f0156a93389ab9cc" ]
}
