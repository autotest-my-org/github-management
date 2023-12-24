# Load People Configuration
locals {
  member_config = yamldecode(file("${path.module}/members.yaml"))
}

# Create People
resource "github_membership" "member" {
  for_each = { for member in local.member_config : member.username => member }

  username = each.value.username
  role     = each.value.role
}
