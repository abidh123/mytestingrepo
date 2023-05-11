resource "aws_instance" "App_instance" {
  ami           = "ami-0fdea1353c525c182"
  instance_type = "t2.micro"
  key_name      = "Jenkins-CICD"
  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    password = file("keypair/Jenkins-CICD.pem")
}
provisioner "remote-exec" {
  inline = [ 
    "sudo yum install httpd -y"
   ]
}
  tags = {
    Name = "Example Instance 1"
  }
}
