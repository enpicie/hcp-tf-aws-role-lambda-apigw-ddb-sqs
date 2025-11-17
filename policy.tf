resource "aws_iam_policy" "lambda_apigw_ddb_sqs_full_access" {
  name        = "Terraform-FullAccess-Lambda-APIGateway-DynamoDB-SQS"
  description = "Allows HCP Terraform to provision AWS Lambda, API Gateway, DynamoDB, and SQS resources"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "LambdaFullAccess",
        Effect = "Allow",
        Action = [
          "lambda:*"
        ],
        Resource = "*"
      },
      {
        Sid    = "APIGatewayFullAccess",
        Effect = "Allow",
        Action = [
          "apigateway:*"
        ],
        Resource = "*"
      },
      {
        Sid    = "DynamoDBFullAccess",
        Effect = "Allow",
        Action = [
          "dynamodb:*"
        ],
        Resource = "*"
      },
      {
        Sid    = "S3AccessForLambdaDeployment",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetObjectTagging",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::enpicie-dev-lambda-artifacts",
          "arn:aws:s3:::enpicie-dev-lambda-artifacts/*",
          "arn:aws:s3:::enpicie-prod-lambda-artifacts",
          "arn:aws:s3:::enpicie-prod-lambda-artifacts/*"
        ]
      },
      {
        Effect : "Allow",
        Action : [
          "kms:GenerateDataKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:DescribeKey"
        ],
        Resource : "arn:aws:kms:us-east-2:637423387388:key/*"
      },
      {
        Sid = "PassRoleForLambda",
        Effect : "Allow",
        Action : "iam:PassRole",
        Resource : "*",
        Condition : {
          StringLikeIfExists : {
            "iam:PassedToService" : "lambda.amazonaws.com"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:GetRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:GetRolePolicy",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:ListInstanceProfilesForRole",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:CreatePolicyVersion",
          "iam:DeletePolicyVersion",
          "iam:ListPolicyVersions"
        ],
        Resource = [
          "arn:aws:iam::637423387388:role/LambdaExecutionRole-*",
          "arn:aws:iam::637423387388:role/LambdaPolicy-*",
          "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
        ]
      },
      {
        Sid    = "CloudWatchLogs",
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Sid    = "SQSFullAccess",
        Effect = "Allow",
        Action = [
          "sqs:*"
        ],
        Resource = "*"
      }
    ]
  })
}
