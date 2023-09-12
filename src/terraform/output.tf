output "cluster_name" {
  value = module.eks.cluster_name
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = module.bastion.public_ip
}