# Chicago Crimes Analysis: Big Data Analytics 🚓 📊

## 📌 Project Overview
This application performs aggregate analysis and interactive querying on a large historical dataset of Chicago crimes (2001-2021). It is designed as a full-stack solution leveraging distributed computing frameworks.

## 🛠️ Architecture & Methodology

### 1. Data Processing Layer (Spark & Scala)
* Implemented a data pipeline using **Apache Spark** and **Scala**.
* Used **Spark SQL** and DataFrames for optimized querying, utilizing in-memory caching and filter pushdown techniques.
* Developed complex aggregation logic (temporal grouping, crime type ranking) and regex-based data manipulation.

### 2. Backend Layer (Spring Boot)
* Designed a REST API using **Spring Boot** integrated with Scala.
* Implemented Controllers to expose endpoints and handle JSON serialization of analytical results.

### 3. Frontend Layer (Flutter)
* Built a cross-platform interactive dashboard using **Flutter** (MVC pattern).
* Integrated dynamic widgets for statistical visualization and geospatial maps to analyze crime density by Community Area.

## 💻 Tech Stack
* **Big Data:** Scala, Apache Spark (Spark SQL)
* **Backend:** Java, Spring Boot, REST API
* **Frontend:** Flutter, Dart
* **Language:** Scala, Java

---
*For full details, please refer to the [Project Report PDF](./docs/Chicago_Crimes_Report.pdf).*
