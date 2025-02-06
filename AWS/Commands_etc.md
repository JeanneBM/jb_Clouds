https://calculator.s3.amazonaws.com/index.html

LOG IN: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html 
ssh -i /path/my-key-pair.pem my-instance-user-name@my-instance-public-dns-name ssh -i /path/my-key-pair.pem my-instance-user-name@my-instance-IPv6-address

ssh -i Klucz.pem ubuntu@ip

AWS - Amazon Web Services 
VPC - Virtual Private Cloud 
EC2 - Elastic Compute Cloud 
AMI - Amazon Machine Images 
EBS - Elastic Block Store 
EFS - Elastic File System 
ECR - Elastic Container Registry 
S3 - Simple Storage Service 
IAM - Identity and Access Management
ACL - Access Control List
MFA - Multi-Factor Authentication 
SNS - Simple Notification Service 
SQS - Simple Queue Service 
CLI - Command Line Interface

Auto Scaling:

Windows Prompt
Launch Configuration: 
aws autoscaling create-launch-configuration --launch-configuration-name name1 --image-id ami-1234567890123456a --instance-type m1.medium

Create an Auto Scaling Group: 
aws autoscaling create-auto-scaling-group --auto-scaling-group-name groupname1 --launch-configuration-name name1 --min-size 1 --max-size 3 --vpc-zone-identifier subnet-1abc2345

PowerShell: New-ASLaunchConfiguration -LaunchConfigurationName name1 -InstanceType "m1.medium" -ImageId "ami-1234567890123456a" -profilename profilename1 Set-AWSCredentials -AccessKey AUYMNUHJKMI5114KN -SecretKey jnfhslj5541844152afcmfjnjuasygfhnhjdksADCa -StoreAs profilename1 New-ASAutoScalingGroup -AutoScalingGroupName groupname1 -LaunchConfigurationName name1 -MinSize 1 -MaxSize 3 -AvaliabilityZone "us-east-la" -profilename profilename1
Building and Managing AWS Solution
CLI: aws configure
