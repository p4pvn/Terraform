I will create policies as per requirements and attached it to the roles mainly consists of Viewer, Developer, and Maintainer.
which is called Role based access control (RBAC) where you get access as per your role.

Apart from this, i will also try to implement ABAC (Attribute based access control) which means you will get access as per tags attached.
like if you have tags env, Project, Owner and if their values get match to conditions you will get access.

We will also try to use AWS managed policies as per job function that comes readymade by AWS.

Flow will be ->

Policies  -->  Roles  --> Assume role by EC2 nodes 
Policies  --> Groups  --> IAM User
