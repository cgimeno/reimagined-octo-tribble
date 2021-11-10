module "ci-roles" {
    source = "./modules/ci-roles"
    environment = var.environment
    account = var.account
}