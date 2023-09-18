module "ebs_csi_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "ebs_csi"

  # 밑에서 csi driver를 통해 생성한 policy를 attach
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               =  module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:ticketing-ebs"]
    }
  }
}

resource "kubernetes_service_account" "ticketing_ebs" {
  metadata {
    name = "ticketing-ebs"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.ebs_csi_eks_role.iam_role_arn
    }
  }
}

resource "helm_release" "ebs_csi_driver" {
  name       = "aws-ebs-csi-driver"
  namespace  = "default"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    type  = "string"
    value = module.ebs_csi_eks_role.iam_role_arn
  }
}

# 새로운 storage class 생성
resource "kubernetes_storage_class" "gp3-storage" {
  depends_on = [helm_release.ebs_csi_driver, module.ebs_csi_eks_role]
  metadata {
    name = "gp3-storage"
    # annotations = {
    #   "storageclass.kubernetes.io/is-default-class" = "true"
    # }
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
  allow_volume_expansion = true
  parameters = {
    "encrypted" = "false"
    "fsType" = "ext4"
    "type" = "gp3"
  }
}