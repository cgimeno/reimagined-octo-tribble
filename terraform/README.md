# terraform
This folder contains a terraform module for:

 - Creating a new role with no permissions that can be assumed by users within the same account
 - A policy allowing users / entities to assume the newly created role
 - A group with the new policy attached
 - A user which belongs to the new group

Structure of the module has been creating taking into account that several environments will exist. If you want to add more environments, just add a new folder for it into the env folder

## Usage

For initializing the backend use, the following:

    terraform init -backend-config=./env/dev/backend.tf

Once initialized, just run terraform providing the required variables

    terraform plan -var-file=env/dev/terraform.tfvars -out plan
