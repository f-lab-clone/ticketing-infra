resource "random_password" "basic_auth_password" {
  length           = 32
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "basic_auth_secret" {
  type = "Opaque"
  metadata {
    name = "remote-write-basic-auth"
    namespace = "monitoring"
  }
  data = {
    "auth" : "remote_write_user:${bcrypt(random_password.basic_auth_password.result)}"
    # It always says changed when "terraform apply", but it's not actually changed
    # I think because of the "bcrypt" function
  }
}