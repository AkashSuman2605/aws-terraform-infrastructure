# AWS Terraform High Availability Infrastructure

## Overview

This project provisions a production-style AWS infrastructure using Terraform and reusable modules.

The infrastructure is designed with high availability, scalability, and automation in mind by leveraging AWS networking, load balancing, monitoring, and auto-scaling services.

---

## Architecture Components

* VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* Application Load Balancer (ALB)
* Network Load Balancer (NLB)
* Launch Template
* Auto Scaling Group (ASG)
* CloudWatch Monitoring
* SNS Notifications
* Route 53

---

## Project Structure

```text
aws-terraform-ha-infrastructure/
│
├── modules/
│   ├── vpc/
│   ├── alb/
│   ├── nlb/
│   ├── asg/
│   ├── sns/
│   └── cloudwatch/
│
├── environments/
│   └── prod/
│
├── providers.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── main.tf
└── README.md
```

---

## Technologies Used

* Terraform
* AWS
* VPC
* ALB
* NLB
* Auto Scaling Group
* CloudWatch
* SNS
* Route 53

---

## Features

* Infrastructure as Code (IaC)
* Reusable Terraform Modules
* High Availability Architecture
* Auto Scaling
* Load Balancing
* Monitoring and Alerting
* Scalable and Automated Infrastructure

---

## Current Status

Project Under Development 🚀

Upcoming Implementations:

* VPC Module
* ALB Module
* NLB Module
* Auto Scaling Module
* CloudWatch Monitoring
* SNS Alerts
* Route 53 Integration
* Architecture Diagram

