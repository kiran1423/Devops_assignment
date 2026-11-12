resource "aws_iam_group" "group1" {
  name = "group1"
}

resource "aws_iam_group" "group2" {
  name = "group2"
}

resource "aws_iam_user" "engine" {
  name = "engine"
}

resource "aws_iam_user" "ci" {
  name = "ci"
}

resource "aws_iam_user" "john" {
  name = "john"
}

resource "aws_iam_user" "cena" {
  name = "cena"
}

resource "aws_iam_user_group_membership" "engine" {
  user   = aws_iam_user.engine.name
  groups = [aws_iam_group.group1.name]
}

resource "aws_iam_user_group_membership" "ci" {
  user   = aws_iam_user.ci.name
  groups = [aws_iam_group.group1.name]
}

resource "aws_iam_user_group_membership" "john" {
  user   = aws_iam_user.john.name
  groups = [aws_iam_group.group2.name]
}

resource "aws_iam_user_group_membership" "cena" {
  user   = aws_iam_user.sarah.name
  groups = [aws_iam_group.group2.name]
}

resource "aws_iam_user_policy" "ci_policy" {

  name = "ci-least-privilege-policy"
  user = aws_iam_user.ci.name

  policy = file("${path.module}/ci-policy.json")
}
