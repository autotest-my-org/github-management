# Load Team Configuration
locals {
  teams = yamldecode(file("${path.module}/teams.yaml")).teams
}

# Create Team
resource "github_team" "teams" {
  for_each = { for team in local.teams : team.name => team }

  name                      = each.value.name
  description               = each.value.description
  privacy                   = each.value.privacy
}

resource "github_team_membership" "team_membership" {
  for_each = { for team in local.teams : team.name => team.members }
  
  team_id = github_team.teams[each.key].id
  username = each.value[0]
}
