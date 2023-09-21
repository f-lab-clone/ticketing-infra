output "cluster_name" {
  value = module.eks.cluster_name
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = module.bastion.public_ip
}

output "password" {
  value     = random_password.basic_auth_password.result
  sensitive = true
}