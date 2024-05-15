## Introduction

Our primary goal was to build a scalable and efficient backend for a ticketing service that could handle high loads with minimal latency. The project focuses exclusively on the backend and infrastructure aspects, omitting a frontend interface to concentrate on the underlying mechanics and performance. This repository highlights the infrastructure conponents, illustrating our journey through building infrastructure, creating CI/CD pipelines, and managing containers. 

<b>Programming Language & Framework</b>: We chose <b>Kotlin</b> and <b>Spring Boot</b> for their expressive syntax and the powerful suite of tools for building web applications efficiently.

<b>Database</b>: We utilized <b>MySQL</b> for its powerful database locking functions, which are essential in managing concurrent operations effectively within our ticketing system. This capability ensures data integrity and consistent performance under high-load scenarios.

<b>Containerization & Orchestration</b>: <b>Kubernetes</b> was used to manage our containerized applications, enabling easy scaling and management across multiple servers hosted on AWS.

<b>Configuration Management</b>: <b>Helm charts</b> helped us streamline the installation and management of our Kubernetes applications.

<b>Continuous Deployment</b>: <b>ArgoCD</b> was employed to automate the deployment process, ensuring our changes were seamlessly and reliably pushed to production.

<b>Infrastructure as Code</b>: <b>Terraform</b> allowed us to define our infrastructure using configuration files, which helped in maintaining consistency and ease of deployment across environments.

<b>Performance Testing</b>: We employed <b>K6</b> to conduct spike tests, simulating scenarios with excessive simultaneous access to evaluate the performance and robustness of our system under extreme conditions. 

<b>Monitoring</b>: We integrated <b>Prometheus</b> and <b>Grafana</b> to monitor our applications and infrastructure, ensuring high availability and performance through real-time insights.

<img src="https://github.com/f-lab-clone/ticketing-backend/assets/41976906/b728aab9-d2ce-41bd-a448-c5c181b61453"  width="70%" height="70%"/>


## Infrastructure

![image](https://github.com/f-lab-clone/ticketing-backend/assets/41976906/354a8f92-852c-4cd1-8713-de05e8aa83f0)

In the course of developing our infrastructure, we tackled a range of infrastructure challenges and optimizations. Below are key resources and discussions that provide insights into our decision-making process and the solutions we implemented:

#### Deployment and Configuration with Terraform

- **[Building the Deployment Environment with Terraform](https://github.com/f-lab-clone/ticketing-infra/issues/1)**: This issue tracks our use of Terraform to automate the provisioning of our entire cloud environment, focusing on reliability and scalability.

#### Cost Optimization Strategies

- **[Migration from AWS ALB to Nginx Ingress (Baremetal)](https://github.com/f-lab-clone/ticketing-infra/issues/42)**: To reduce costs, we replaced AWS ALB with a more cost-effective Nginx Ingress setup on bare metal. This discussion details the reasons behind the change and the implementation process.
- **[Using Public Subnet Node Group to Address NAT Gateway Cost Issues](https://github.com/f-lab-clone/ticketing-infra/issues/61#issuecomment-1748931936)**: We opted to configure our EKS cluster using a public subnet node group to avoid high costs associated with NAT gateways.

#### Monitoring and Metrics

- **[How to Scrape Metrics from Multiple Pods Using Spring Actuator](https://medium.com/@hayounglim/prometheus-helm-how-to-scrape-metrics-from-multiple-pods-using-spring-actuator-08fccd0cf69e)**: This article explains how we set up Prometheus, via Helm, to scrape metrics from multiple pods, enhancing our monitoring capabilities using Spring Boot’s Actuator.

#### Security Enhancements

- **[Injecting Secrets into EKS Pods Using Terraform](https://devkly.com/devops/terraform-secret-manager/)**: We explored methods to securely inject secrets into our Kubernetes pods using Terraform, ensuring sensitive data is managed safely and effectively.


## Backend

![Queue System Architecture](https://github.com/f-lab-clone/ticketing-backend/assets/41976906/37d47dc4-c795-437e-afb8-c13957f2c3b6)

- **[Queue System Design Issues](https://github.com/f-lab-clone/ticketing-backend/issues/72#issuecomment-1763249911)**: Discusses considerations for preventing update losses, implementing non-blocking APIs, and choosing data structures for the queue system.

#### Project Package Structure and Conventions

- **[Project Package Structure Considerations](https://github.com/f-lab-clone/ticketing-backend/wiki/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%ED%8C%A8%ED%82%A4%EC%A7%80-%EA%B5%AC%EC%A1%B0)**: Deliberations on how to organize the project's package structure effectively.
- **[Convention Documentation](https://github.com/f-lab-clone/ticketing-backend/wiki/Convention)**: Defines conventions for branch naming, commit messages, HTTP response structures, serialization, testing, and more.

#### API Optimization and Testing

- **[API Enhancement Considerations](https://github.com/f-lab-clone/ticketing-backend/issues/52)**: Detailed discussion on time conventions, data transfer between layers (errors, responses), logging best practices, and their implementation.
- **[Maintaining Over 80% Test Coverage with Jacoco and Codecov](https://github.com/f-lab-clone/ticketing-backend/issues/5)**: Outlines strategies and efforts to maintain a high level of test coverage using Jacoco and Codecov.
- **[Integration Testing Environment with Testcontainers and MySQL Container](https://github.com/f-lab-clone/ticketing-backend/issues/31)**: Describes the setup of an integrated testing environment using Testcontainers and a MySQL Docker container to enhance testing reliability and consistency.

## CD Pipeline

<img width="1085" alt="image" src="https://github.com/f-lab-clone/ticketing-backend/assets/41976906/00651cfb-8e03-4857-bc3b-14a400c84cbe">


## Performance Test 

![Performance Test Result](https://github.com/f-lab-clone/ticketing-backend/assets/41976906/5cc5b165-fdde-4b67-968f-b94dfc037cfd)

- **[Considerations for Building the Performance Test Environment](https://github.com/f-lab-clone/ticketing-infra/issues/32)**: A detailed discussion on the setup and challenges of creating a suitable environment for performance testing.
- **[Detailed Performance Test Scenarios](https://github.com/f-lab-clone/ticketing-infra/wiki/Desired-State%EB%A5%BC-%EC%A4%91%EC%8B%AC%EC%9C%BC%EB%A1%9C-%EC%82%B4%ED%8E%B4%EB%B3%B4%EB%8A%94-%EC%9D%B8%ED%94%84%EB%9D%BC-%ED%99%98%EA%B2%BD#%EC%96%B4%EB%96%BB%EA%B2%8C-%EC%84%B1%EB%8A%A5-%ED%85%8C%EC%8A%A4%ED%8A%B8-%ED%99%98%EA%B2%BD%EC%9D%84-%EA%B5%AC%EC%84%B1%ED%96%88%EB%8A%94%EA%B0%80)**: This link provides a thorough description of the performance test scenarios used in our project.

#### Cost Management and Test Scripts

- **[Calculating Costs for Spike Testing Using ALB LCU](https://github.com/f-lab-clone/ticketing-infra/issues/62)**: An analysis of cost implications when using AWS ALB Load Capacity Units (LCU) for spike testing.
- **[Creating K6 Performance Test Scripts](https://github.com/f-lab-clone/ticketing-backend/issues/83)**: Discussion and documentation on how we developed K6 scripts for our performance testing.

#### Database and Monitoring Setup

- **[Database Setup for Test Data and Large-Scale Data Insertions](https://github.com/f-lab-clone/ticketing-backend/issues/101)**: Outlines our approach to preparing the database for testing, including the creation of large datasets.
- **[Building a Monitoring Environment with Prometheus and Grafana](https://github.com/f-lab-clone/ticketing-infra/issues/30)**: Details on how we configured Prometheus and Grafana to monitor our application and infrastructure during the performance tests.


## Performance Test Report 

#### [SignIn Spike Test Report](https://github.com/f-lab-clone/ticketing-backend/issues/105)
- Improved Slow Queries by adding an index to a single-column with 1 million records.
- Observed changes in CPU performance due to encryption: increased CPU core count and observed changes in encryption difficulty based on [encryption level adjustments](https://github.com/f-lab-clone/ticketing-backend/issues/107).

#### [JVM Warm Up Test Report](https://github.com/f-lab-clone/ticketing-backend/issues/108)
- Observed changes in JVM CodeHeap and performance by repeating the same test after process creation.

#### [3000 Requests Per Minute Spike Test Report](https://github.com/f-lab-clone/ticketing-backend/issues/135)
- Improved performance of `SELECT COUNT(*)` on ten million records by implementing [NoOffset](https://github.com/f-lab-clone/ticketing-backend/issues/113).
- Introduced a queue system after considering competition for locks on a single resource (=Event) and observed tests.

#### [6000 Requests Per Minute Spike Test Report](https://github.com/f-lab-clone/ticketing-backend/issues/144)
- Improved CPU resource usage by modifying thread pool strategy for thread creation.
- Improved Pending Connection by modifying DB Connection Pool strategy.
- Improved latency by applying Redis caching.


## Contributors

| Junha Ahn | Hayoung Lim | Jeongseop Park | Minjun Kim | 
| :----: | :----: | :----: |:----: |
| [@junha-ahn](https://github.com/junha-ahn) | [@hihahayoung](https://github.com/hihahayoung) | [@ParkJeongseop](https://github.com/ParkJeongseop) | [@minjun3021](https://github.com/minjun3021) |
|Infrastructure (Leader) |Infrastructure |Backend |Backend |
