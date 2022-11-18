# Building an EKS cluster

To build this EKS cluster we have used as reference the content of this Terraform Tutorial: [Provision and EKS Cluster (AWS)](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks).

There are a couple of diferences in relation to what you can find in that Tutorial:

1. We were hitting this issue: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1986 and so we implemented the suggested workaround: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1986#issuecomment-1112635625
2. We need to declare the VPC name, AWS Region and define as enviromental variables the AWS credentials:

   * AWS_ACCESS_KEY_ID
   * AWS_SECRET_ACCESS_KEY
   * AWS_SESSION_TOKEN [Optional]

---
