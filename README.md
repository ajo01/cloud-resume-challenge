# AWS Cloud Resume Challenge

The Cloud Resume Challenge is a hands-on project designed to develop practical cloud skills. Steps involve automated testing, building CI/CD pipelines, database integration, DNS configuration, templating infrastructure as code, and more.
Read more about the challenge [here](https://cloudresumechallenge.dev/docs/the-challenge/aws/).

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
- [x] Tests

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

### Step 4 - Cloudfront CDN Distribution

I created a Cloudfront content delivery network to speed up the distribution of my website. The origin domain was set to the S3 bucket, the domain name to www.amyjo.cloud, and subdomain name to amyjo.cloud.

### Step 5 - Custom Certificate Request

To enable HTTPS, I requested a certificate in AWS ACM for the domain names www.amyjo.cloud and amyjo.cloud. In Godaddy, I then updated the CNAME records with the certificate's CNAME values.

### Step 6 - Route53 DNS

I transferred my domain to AWS's domain name service (DNS) Route53. I first created a public hosted zone within Route53 with the domain name www.amyjo.cloud then changed nameservers at Godaddy to use Route53's nameservers.

### Step 7 - Visit Counting with DyanmoDB

I provisioned a DynamoDB table with the attribute key and views.

| Key        | Views           |
| ------------- |:-------------:|
| String      | Number |

### Step 8 - Visit Counting with AWS Lambda

I created an AWS Lambda function with the AWS SDK for Python, Boto3. The function updates the view attribute in the dynamodb table and returns the number of views. Function URL was enabled so that we could request the URL directly instead of provisioning an API Gateway. This Lambda function was also allowed to assume an IAM role that had permissions to access DynamoDB.

```python
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('cloudresume')

def handler(event, context):
    response = table.get_item(Key={
        'id':'1'
    })
    views = response['Item']['views']
    views += 1
    response = table.put_item(Item={
            'id':'1',
            'views': views
    })

    return views
```

### Step 9 - Update Website with Visit Counter

I updated the website to fetch the Lambda function URL and display the number of views.

### Step 10 - Infrastructure as Code

I automated infrastructure with [Terraform](https://www.terraform.io/).
I migrated the resources to Terraform by configuring the files, `terraform importing` the resources and using `terraform plan` to carefully observe changes.

`terraform init` initializes Terraform configuration files

`terraform apply` deploys the specified resources

`terraform destroy` destroys all resources specified in Terraform's configuration files

### Step 11 - Frontend CI/CD Workflow

I setup a CI/CD workflow with Github Actions so that upon every push on Git, the code will build and sync to the S3 bucket. AWS credentials were stored in GitHub Secrets.

### Step 12 - Backend CI/CD Workflow

I setup a CI/CD workflow with Github Actions so upon every approved merge request, Terraform will update remote resources.

### Step 13 - Automated Testing

I setup automated testing with Jest and Supertest to ensure the Visit Count Lambda function was running correctly.

`npx jest aws.test.js`

## Challenges
Due to how Cloudfront and DNS routing works, sometimes it took up to 24 hours for any changes in code or domain name to appear. This is still the case for any code pushes in the frontend app, making it difficult to validate changes in production. To handle this, I setup live Vercel deployments to ensure the expected changes were there.


I also set my region as `ca-central-1` (West Canada) for my Terraform provider as this was the closest location to me. This was problematic as a certificate from the AWS Certificate Manager could only be requested from `us-east-1` in order to use it with Cloudfront. Setting up multiple providers in a convenient way in Terraform took some time but I eventually succeeded by differentiating the default and aliased providers.


In addition, I didn't want any downtime during the transition of my manually provisioned AWS resources to the ones provisioned by Terraform. I did more research and discovered I could import manually created resources, which I did so. After importing all my resources, I used the `terraform plan` command to ensure there were minimal changes and that no resources were being destroyed.
