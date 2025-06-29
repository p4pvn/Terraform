terraform {
  backend "s3" {

    # This bucket MUST exist before you run 'terraform init'
    # It should have versioning enabled for state history and recovery.
    bucket = "your-terraform-state-bucket-unique-name"

    # The path and filename within the S3 bucket.
    # It's good practice to organize by project/environment.
    key    = "terraform-project/sandbox/ec2-instance/terraform.tfstate"

    # The AWS region where your S3 bucket and DynamoDB table are located.
    # This does NOT have to be the same region where your EC2 instance is deployed.
    region = "us-east-1"

    # Enable server-side encryption for your state file at rest in S3 for security.
    encrypt = true

    # Enable state locking using a DynamoDB table.
    # This table MUST exist before you run 'terraform init'
    # It must have a primary key named 'LockID' (case-sensitive, type String).
    dynamodb_table = "terraform-lock-table" # Replace with your DynamoDB table name
  }
}
