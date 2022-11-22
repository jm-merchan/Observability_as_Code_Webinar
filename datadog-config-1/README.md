# Deploying Datadog Agent, Monitors, Dashboard, ...

This repo is based on [Automate Monitoring with the Terraform Datadog Provider tutorial](https://developer.hashicorp.com/terraform/tutorials/applications/datadog-provider), which has been extended to deploy the eCommerce application using HCL.

If you want to run this code locally update the kubernetes.tf file with the following

Instead of this

```bash
data "terraform_remote_state" "eks" {
  backend = "remote"

  config = {
    organization = var.org_name
    workspaces = {
      name = "eks-cluster"
    }
  }
}
```

Use this

```bash
data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../eks-cluster/terraform.tfstate"
  }
}
```

and remove the org_name variable from the variables.tf

You can define the rest of the variables using a **tfvars** file

---

The files advertisements.tf, db.tf, discount.tf and frontend.tf are the result of running 

```bash
tfk8s -f input.yaml -o output.tf
```

on the different yaml manifest that comprised the eCommerce application, where input and output should be changed with the name portion of the manifest (advertisement, db, and so on). They have made available within the eCommerce_app folder and have been taken from the original repository [DataDog/ecommerce-workshop](https://github.com/DataDog/ecommerce-workshop/tree/main/deploy/generic-k8s/ecommerce-app)
