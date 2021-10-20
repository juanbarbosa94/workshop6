output "intance_public_ipv4_address" {
  value = aws_instance.workshop6app-mentor.public_ip
  description = "this is the public ipv4 address"
}
