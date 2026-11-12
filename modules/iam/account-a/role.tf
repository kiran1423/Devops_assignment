resource "aws_iam_role" "roleA" {
  name = "roleA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        AWS = "arn:aws:iam::000000000000:root"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "roleA_policy" {

  name = "roleA-admin-except-iam"
  role = aws_iam_role.roleA.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      NotAction = [
        "iam:*"
      ]

      Resource = "*"
    }]
  })
}

resource "aws_iam_role" "roleB" {

  name = "roleB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        AWS = "arn:aws:iam::000000000000:root"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "roleB_policy" {

  name = "roleB-assume-roleC"
  role = aws_iam_role.roleB.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "sts:AssumeRole"
      ]

      Resource = [
        "arn:aws:iam::111111111111:role/roleC"
      ]
    }]
  })
}
