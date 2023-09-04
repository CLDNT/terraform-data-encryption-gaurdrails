# Secure AWS S3 Bucket with Data Encryption

This Terraform project provides code to create a secure Amazon S3 bucket on AWS with strong encryption settings. It follows best practices for data encryption and access control to protect sensitive data in your storage environment.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Customization](#customization)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Data security is paramount when storing sensitive information in the cloud. This Terraform project aims to help you create a secure S3 bucket with encryption and access controls to safeguard your data.

## Features

- Creates an S3 bucket with server-side encryption using AES256.
- Defines an IAM policy to deny object deletion without secure transport.
- Restricts access to the S3 bucket to specific IP addresses using an S3 bucket policy.

## Prerequisites

Before using this Terraform code, ensure you have the following:

1. An AWS account with appropriate permissions.
2. Terraform installed on your local machine.

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/secure-s3-bucket.git
2. Initialize your Terraform workspace:
    terraform init

3. Review and customize the configuration in main.tf and if needed.
    terraform apply
4. Apply the configuration to enforce MFA for IAM users
    terraform destroy

Configuration

    main.tf: Contains the main Terraform configuration for enforcing MFA.
    provider.tf: Specifies the AWS provider and region.
