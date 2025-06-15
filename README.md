# AWS #Terraform #Terragrunt
This repository contains a production-grade AWS 3-tier architecture Project and infrastructure management setup using Terraform, with additional configuration and environment flexibility provided by Terragrunt.
Used AWS Services like CloudFront, Route53, EC2s, S3, EKS, IAM, RDS and several operations like Disk Snapshot, Cache Invalidation, Auto CleanUp, AWS Lambda tasks.

1. Current Status of the Project:
Currently, I am still crafting the .tf code for every AWS resource along with variables as per environments.
The structure of the directory is explained in point number 3.

2. RoadMap:
- create directory structure for complete terraform project. DONE
- write terraform code to implement resources in develop environments. WIP
- add variables accordingly for different environments like prod, and non-prod. pending
- add pipeline logic for smoother deployments. pending
- go ahead and apply it for all environments and make the project live. pending

3. Directory Structure:
- let's consider we have 2 clusters, one is a stateless cluster-1 like any application/microservices that doesn't maintain user sessions, and another one (cluster-2) is stateful and maintains user sessions and talks to microservices clusters in order to provide data and other logic.
- Also, like any other global product, we also have 4 environments (develop, QA, nonprod, PROD).
- now, since we have a total 8 requirements (4x2 = 8) since we have 2 clusters on all 4 environments, it might look like we may need to manage 8 different code repositories.
- But that goes against DevOps principle (DRY - Don't repeat yourself) and let's be honest, managing 8 different repos is no easy task and defeats the purpose of why we have env in the first place.
- hence, here we have made a single repository for all infrastructure code stored at "terraform/terraform-stacks" and changed logic according to clusters in "terraform/terraform-deployments" and added appropriate resource values (cloud bills are no joke) according to environments in "terraform/terraform-environment" and will automate apply using pipeline logic stored in "terraform/pipeline"


![image](https://github.com/user-attachments/assets/669d3f78-1ec6-4c31-b50f-fb66cb17da3a)

