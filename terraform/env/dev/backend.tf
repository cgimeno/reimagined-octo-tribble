bucket = "terraform-test-loc3oshi"
profile = "dev-us-west-2"
key = "terraform/terraform.tfstate"
region = "us-west-2"
encrypt = true
# dynamo_table = "tf-lock" In case that we want to use dynamo for blocking concurrent modifications to the tfstate
