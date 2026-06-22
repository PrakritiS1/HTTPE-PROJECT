## Capacity Planning & Cost Analysis

We estimate infrastructure requirements and costs at three scales:
- 1,200 TPS (Current)
- 12,000 TPS (Target)
- 24,000 TPS (2x Target)

---

# 1. Compute Requirements

## 1,200 TPS (Current)
- App Servers: 4 EC2 (m5.large)
- CPU: 16 vCPU total
- Memory: 32 GB total

## 12,000 TPS (Target)
- App Servers: 20 EC2 (m5.xlarge)
- CPU: 80 vCPU total
- Memory: 160 GB total

## 24,000 TPS (Peak)
- App Servers: 40 EC2 (c5.2xlarge)
- CPU: 160 vCPU total
- Memory: 320 GB total

---

#  2. Storage Requirements

## 1,200 TPS
- Database: 200 GB
- Logs: 100 GB/month

## 12,000 TPS
- Database: 2 TB
- Logs: 800 GB/month

## 24,000 TPS
- Database: 4 TB
- Logs: 1.5 TB/month

---

#  3. Network Requirements

## 1,200 TPS
- 200 Mbps throughput

## 12,000 TPS
- 2 Gbps throughput

## 24,000 TPS
- 5 Gbps throughput

---

#  4. Cost Estimation (AWS)

## Assumptions:
- EC2 On-demand pricing average:
  - small: $70/month
  - medium: $140/month
  - large: $280/month
- RDS + Storage + Network included approximate

---

## 1,200 TPS Cost

| Component | Cost |
|-----------|------|
| EC2 (4 instances) | $280 |
| Database (RDS) | $200 |
| Storage | $100 |
| Network | $50 |
| **Total** | **$630/month** |

---

## 12,000 TPS Cost

| Component | Cost |
|-----------|------|
| EC2 (20 instances) | $2,800 |
| Database (Clustered RDS) | $1,200 |
| Storage (2 TB) | $600 |
| Network | $300 |
| **Total** | **$4,900/month** |

---

## 24,000 TPS Cost

| Component | Cost |
|-----------|------|
| EC2 (40 instances) | $5,600 |
| Database (Multi-node cluster) | $2,500 |
| Storage (4 TB) | $1,200 |
| Network | $600 |
| **Total** | **$9,900/month** |

---

#  5. Budget Validation

- Maximum allowed budget: **$45,000/month**
- Peak cost: **$9,900/month**

✔ System is well within budget limits

---

#  6. Cost Optimization Strategies

## 1. Reserved Instances
- Save up to 40% cost on EC2

## 2. Spot Instances
- Use for batch processing & non-critical workloads

## 3. Right Sizing
- Scale down idle servers during low traffic

## 4. Auto Scaling
- Scale dynamically based on TPS

## 5. Cache Optimization
- Reduce database load using Redis

---

# Conclusion
The system is cost-efficient and scalable up to 24,000 TPS while staying under the budget constraint of $45,000/month.