1.Add a lifecycle block preventing accidental deletion of one specific instance of your choosing, and explain in NOTES.md which one and why.
A. Added a lifecycle block to preventing accidental deletion of prod web server or prod db server, prod servers should be up and running 24/7

2.A short explanation of what happens today (with local state) if two people run apply at the same time, and how your backend change prevents that.
A. With local state file if two people run apply at the same time, and both are trying to modify same resource then there is a change of conflict and state file may corrupt.
If we store state file in remote backend like s3 and dynamodb lock will allow to run only one apply at a time, this will prevent conflicts and state file corruption.
s3 backend and dynamodb lock - If two people run apply at the same time, it will allow to run apply for the first person and second person will get error.

3. Would you actually give engine and ci IAM users with access keys in a real production setup, or would you do something different? Explain.
A. In a real production environment, I would generally avoid creating IAM users with access keys whenever possible.
A more secure approach is:
For workloads running in AWS (EC2, ECS, EKS, Lambda), use IAM roles attached directly to the workload.
For human administrators, use AWS Identity Center (SSO) and role assumption instead of IAM users.

Task 5:
data "aws_iam_policy_document" "roleC_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::000000000000:role/roleB"]
    }
  }
}

resource "aws_iam_role" "roleC" {
  name               = "roleC"
  assume_role_policy = data.aws_iam_policy_document.roleC_trust.json
}

resource "aws_iam_role_policy" "roleC_s3" {
  name = "roleC-s3-access"
  role = aws_iam_role.roleC.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::my-named-target-bucket",
          "arn:aws:s3:::my-named-target-bucket/*"
        ]
      }
    ]
  })
}

Two bugs in Task 5:

1. Policy Mismatch: The principal identifier was incorrectly set to user/roleB instead of role/roleB.
2. Broad Permissions: The inline policy used Action = "s3:*" on Resource = "*" instead of scoping access to a single named S3 bucket.
