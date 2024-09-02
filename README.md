# AWS Cloud Resume Challenge

The Cloud Resume Challenge is a hands-on project designed to develop practical cloud skills. Steps involve automated testing, building CI/CD pipelines, database integration, DNS configuration, templating infrastructure as code, and more.
Here I have documented my attempt at this challenge. Read more about the challenge [here](https://cloudresumechallenge.dev/docs/the-challenge/aws/).

## Architecture Diagram

![awsdiagram](https://github.com/user-attachments/assets/611db14b-5e75-4d32-968e-45d70f41f837)

## [Demo](https://amyjo.cloud/)

## Progress

- [x] AWS Certification CCP + CSAA
- [x] Static Website
- [x] HTTPS with Cloudfront
- [x] DNS with Route53
- [x] Lambda and DynamoDB for Visit Counter
- [x] Source Control
- [x] CI/CD Frontend
- [x] Infrastructure as Code

- [ ] Tests

## Tech Stack:

- S3
- CloudFront
- Certificate Manager
- IAM
- AWS Lambda
- Dynamo DB
- GitHub Actions
- Terraform

## How-To Guide

### Step 0 - Certification

I actually got certified as an AWS Cloud Practitioner and Solutions Architect Assosicate before I had heard about this challenge so I was able to skip this step quickly.
I was certified on May 2022 and January 2024 respectively, which can be verified [here](https://www.credly.com/earner/earned/badge/0bb8639e-fa4c-4cc3-a843-eec3cbb9a748).

### Step 1 - Frontend

Every year I rebuild my portfolio website. For 2024, I had already redesigned my website with React and this was the app I used as my frontend for this challenge.

### Step 2 - Deploy Website to AWS S3 Bucket

Since my app was built with React, I generated static files by running `npm run build`. The build folder was uploaded to the S3 bucket named www.amyjo.cloud.

The S3 bucket's files looks like this:

- asset-manifest.json
- favicon.ico
- index.html
- manifest.json
- robots.txt
- static/

Static website hosting was enabled and index.html was set as the index document. S3 bucket permissions and resource policy were also set to allow public access.

### Step 3 - Website Domain Setup

I bought the custom domain name amyjo.cloud through Godaddy. In Godaddy's DNS configuration settings, I updated the CNAME records with the S3 bucket name.

### Step 4 - Cloudfront CDNm Distribution

I created a Cloudfront content delivery network to speed up the distribution of my website. The origin domain was set to the S3 bucket, the domain name to www.amyjo.cloud, and subdomain name to amyjo.cloud.

### Step 5 - Custom Certificate Request

To enable HTTPS, I requested a certificate in AWS ACM for the domain names www.amyjo.cloud and amyjo.cloud. In Godaddy, I then updated the CNAME records with the certificate's CNAME values.

### Step 6 - Route53 DNS

I transferred my domain to AWS's domain name service (DNS) Route53. I first created a public hosted zone within Route53 with the domain name www.amyjo.cloud then changed nameservers at Godaddy to use Route53's nameservers.

### Step 7 - Visit Counting with DyanmoDB

I provisioned a DynamoDB table with the attribute key and views.

### Step 8 - Visit Counting with AWS Lambda

I created an AWS Lambda function with the AWS SDK for Python, Boto3. The function updates the view attribute in the dynamodb table and returns the number of views. Function URL was enabled so that we could request the URL directly instead of provisioning an API Gateway.

### Step 9 - Update Website with Visit Counter

I updated the website to fetch the Lambda function URL and display the number of views.

### Step 10 - Frontend CI/CD Workflow

I setup a CI/CD workflow with Github Actions so upon every push on Git, the code will build and sync to the S3 bucket.

### Step 11 - Infrastructure as Code

I automated infrastructure with [Terraform](https://www.terraform.io/).

`terraform init` initializes Terraform configuration files

`terraform apply` deploys the specified resources

`terraform destroy` destroys all resources specified in Terraform's configuration files

### Step 12 - Backend CI/CD Workflow

To be continued...
