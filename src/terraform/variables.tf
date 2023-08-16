locals {
  infra_users = [
    module.infra_team_user1,
    module.infra_team_user2,
    module.infra_team_user3,
  ]

  ubuntu_22_ami = "ami-0c9c942bd7bf113a2"
}
