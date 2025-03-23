
# AWS VPC Setup with Public & Private Subnets and EC2 Instance

## Overview  
This guide provides step-by-step instructions to create a **VPC with two subnets (public and private)**, attach an **Internet Gateway**, and launch an **EC2 instance in the public subnet**.  

---

## Prerequisites  
- An **AWS account**  
- AWS Management Console access  
- Basic knowledge of **VPCs, Subnets, and EC2**  

---

## **1. Create a VPC**  
1. Go to **AWS Management Console** → **VPC Dashboard**  
2. Click **Create VPC**  
3. Enter:  
   - **VPC Name:** `your_vpc_name`  
   - **IPv4 CIDR block:** `10.0.0.0/16`  
4. Click **Create VPC**  

---

## **2. Create Subnets (Public & Private)**  

### **Public Subnet:**  
1. Go to **VPC Dashboard** → **Subnets** → **Create Subnet**  
2. Select **VPC:** `your_vpc`  
3. Set:  
   - **Subnet Name:** `Public-Subnet`  
   - **IPv4 CIDR:** `10.0.1.0/24`  
4. Click **Create Subnet**  

### **Private Subnet:**  
1. Click **Create Subnet** again  
2. Select **VPC:** `your_vpc`  
3. Set:  
   - **Subnet Name:** `Private-Subnet`  
   - **IPv4 CIDR:** `10.0.2.0/24`  
4. Click **Create Subnet**  

---

## **3. Attach an Internet Gateway**  
1. Go to **VPC Dashboard** → **Internet Gateways**  
2. Click **Create Internet Gateway**  
3. Enter:  
   - **Name:** `MyIGW`  
4. Click **Create**, then:  
   - **Attach to VPC** → Select **your_vpc** → **Attach**  

---

## **4. Create Route Table for Public Subnet**  
1. Go to **VPC Dashboard** → **Route Tables**  
2. Click **Create Route Table**  
3. Enter:  
   - **Name:** `Public-RT`  
   - **VPC:** `your_vpc`  
4. Click **Create**  
5. Select **Public-RT** → Click **Routes** → **Edit Routes**  
6. Add a new route:  
   - **Destination:** `0.0.0.0/0`  
   - **Target:** `MyIGW`  
7. Click **Save Routes**  
8. Click **Subnet Associations** → **Edit Subnet Associations**  
9. Select **Public Subnet** → Click **Save**  

---

## **5. Launch an EC2 Instance in the Public Subnet**  
1. Go to **EC2 Dashboard** → **Launch Instance**  
2. Set:  
   - **Name:** `MyPublicInstance`  
   - **AMI:** Amazon Linux 2023 / Ubuntu  
   - **Instance Type:** `t2.micro` (Free Tier)  
3. Click **Edit in Advanced Details** → Set **Network**:  
   - **VPC:** `MyVPC`  
   - **Subnet:** `Public-Subnet`  
   - **Auto-assign Public IP:** **Enable**  
4. Create/Select a **Key Pair** for SSH access  
5. Configure **Security Group**:  
   - Allow **SSH (22)** from **Your IP**  
   - Allow **HTTP (80)** / **HTTPS (443)** if needed  
6. Click **Launch**  

---

## **6. Connect to EC2 Instance from Local Machine**  
1. Open **WSL / Terminal**  
2. Run the command:  
   ```bash
   ssh -i path-to-key.pem ubuntu@<Public-IP>

