output "key" {
    value = module.ci-roles.key
    description = "Key of the newly created user"
    sensitive = true

}