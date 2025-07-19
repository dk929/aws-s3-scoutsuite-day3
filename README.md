# Day 3 – Secure S3 Bucket + ScoutSuite Audit

## ✅ What I Did
- Deployed S3 bucket with encryption, versioning, and logging using Terraform
- Blocked all public access by default
- Ran ScoutSuite to audit AWS configuration

## ❓ What I Learned
- Importance of encryption for data-at-rest security
- How versioning prevents accidental deletion or ransomware issues
- Real-world cloud misconfigurations and how to detect them

## ⚠️ Problems I Faced
- Example: ScoutSuite authentication issues
- Example: Terraform bucket name conflicts

## 💡 Fixes
- Updated AWS credentials in Kali
- Added `random_id` resource for unique bucket names
