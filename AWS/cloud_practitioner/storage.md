# Storage Exam Tips - Notes

---

## **1. EC2 Storage Options**

### **EBS (Elastic Block Storage)**
- **Description:** Like a pizza oven directly attached to the kitchen (EC2 instance).
- **Features:**
  - Persistent block storage.
  - Can take backups and create new volumes from them.
- **Use Case:** Ideal for data persistence and durability.

### **EFS (Elastic File System)**
- **Description:** Like a pizza conveyor system serving multiple kitchens (EC2 instances).
- **Features:**
  - Scalable file storage for multiple EC2 instances.
  - Automatically scales on demand without disrupting applications.
- **Use Case:** Shared file storage for multiple instances.

### **Instance Store**
- **Description:** Like a temporary prep table.
- **Features:**
  - Temporary block-level storage with high IOPS.
  - Data is lost if the instance is terminated.
- **Use Case:** High-performance, temporary storage.

---

## **2. Amazon S3 (Simple Storage Service)**

- **Description:** Like a giant walk-in refrigerator for storing ingredients (data).
- **Key Features:**
  - High durability and scalability.
  - Security measures: Bucket policies and ACLs.
  - **Versioning:** Keeps multiple versions of an object.
  - **Lifecycle Policies:** Automates data management (e.g., moving data to cheaper storage classes).

---

## **3. S3 Storage Classes**

| **Storage Class**               | **Description**                                                                 | **Use Case**                                                                 |
|----------------------------------|---------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| **S3 Standard**                 | Primary shelves in the fridge for frequently accessed data.                     | Frequently accessed data.                                                    |
| **S3 Intelligent Tiering**      | Dynamic shelves for data with unpredictable access patterns.                    | Data with unknown or changing access patterns.                               |
| **S3 Standard Infrequent Access (IA)** | Like a pantry for less frequently accessed data.                                | Data accessed less often but requires rapid access.                          |
| **S3 One Zone Infrequent Access** | A special section in the fridge (stored in one Availability Zone).              | Less durable but cost-effective for infrequently accessed data.              |
| **S3 Glacier Instant Retrieval** | Top drawer in the freezer for rarely accessed but important data.               | Rarely accessed data requiring quick retrieval.                              |
| **S3 Glacier Flexible Retrieval** | Deep freezer compartment for less frequently accessed data.                     | Data retrieval in minutes to hours.                                          |
| **S3 Glacier Deep Archive**     | Very bottom of the deep freezer.                                                | Long-term archival with the lowest cost.                                     |

---

## **4. Additional Storage Services**

### **FSX**
- **Description:** Specially designed storage for specific conditions (e.g., Windows workloads).
- **Use Case:** Tailored storage for specialized workloads.

### **Elastic Disaster Recovery**
- **Description:** Backup generator for business continuity.
- **Use Case:** Ensures uninterrupted operations during outages.

### **EBS Volume Types**
- **SSD:**
  - **General Purpose SSD:** Balanced performance.
  - **Provisioned IOPS SSD:** High-performance for critical workloads.
- **HDD:**
  - **Throughput Optimized HDD:** High throughput for large datasets.
  - **Cold HDD:** Low-cost for infrequently accessed data.

### **AWS Storage Gateway**
- **Description:** Like a delivery scooter for data migration between on-premises and AWS.
- **Types:**
  - **File Gateway:** For file-based storage.
  - **Volume Gateway:** For block-based storage.
  - **Tape Gateway:** For backup and archival.
- **Use Case:** Data migration, backup, and archival.

### **AWS Backup**
- **Description:** Like a recipe book for recreating data.
- **Features:**
  - Centralized backup management.
  - Automated backup policies.
  - Cross-region backup for compliance and disaster recovery.
- **Use Case:** Simplifies data protection and recovery.

---

## **5. Key Takeaways**

- **Durability and Persistence:**
  - EBS for persistent block storage.
  - Instance Store for temporary, high-performance storage.
- **Scalability and Shared Access:**
  - EFS for scalable file storage across multiple instances.
- **S3 Features:**
  - Versioning, lifecycle policies, and multiple storage classes for cost optimization.
- **Specialized Storage:**
  - FSX for Windows workloads.
  - Elastic Disaster Recovery for business continuity.
- **Data Migration and Backup:**
  - Storage Gateway for hybrid cloud setups.
  - AWS Backup for centralized, automated backups.

---

## **6. Exam Tips**

- Understand when to use **EBS**, **EFS**, and **Instance Store** based on durability, persistence, and performance needs.
- Be familiar with **S3 storage classes** and their use cases.
- Know the differences between **EBS volume types** (SSD vs. HDD).
- Recognize the role of **AWS Storage Gateway** and **AWS Backup** in data migration and protection.

---

## **7. Next Steps**

- Take the quiz to solidify your understanding.
- Review the key concepts and use cases for each storage service.

---

This markdown file summarizes the key points from the lesson, making it easier to review and prepare for the exam.
