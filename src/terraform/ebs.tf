
# resource "helm_release" "ebs_csi_driver" {
#   name       = "aws-ebs-csi-driver"
#   namespace  = "kube-system"
#   repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
#   chart      = "aws-ebs-csi-driver"

#   set {
#     name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     type  = "string"
#     value = module.ebs_csi_eks_role.iam_role_arn
#   }
# }

# module "ebs_csi_eks_role" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   role_name = "ebs_csi"

#   attach_ebs_csi_policy = true

#   oidc_providers = {
#     main = {
#       provider_arn               =  module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
#     }
#   }
# }

# resource "kubernetes_storage_class" "gp3-storage" {
#   depends_on = [helm_release.ebs_csi_driver, module.ebs_csi_eks_role]
#   metadata {
#     name = "gp3"
#     annotations = {
#       "storageclass.kubernetes.io/is-default-class" = "true"
#     }
#   }

#   storage_provisioner = "ebs.csi.aws.com"
#   volume_binding_mode = "WaitForFirstConsumer"
#   allow_volume_expansion = true
#   reclaim_policy = "Delete"

#   parameters = {
#     "encrypted" = "false"
#     "fsType" = "ext4"
#     "type" = "gp3"
#   }
# }