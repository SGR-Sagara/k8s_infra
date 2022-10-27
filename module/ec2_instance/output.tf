## Instance Public IP
output "instance_public_ip" {
  value = aws_instance.euroleague_utility_node.public_ip
}
