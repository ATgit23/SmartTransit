# 🚌 SmartTransit — Smart Bus Management & Tracking System

<div align="center">

![Java](https://img.shields.io/badge/Java-21-orange)
![MySQL](https://img.shields.io/badge/MySQL-8-blue)
![Tomcat](https://img.shields.io/badge/Tomcat-9-yellow)
![Maven](https://img.shields.io/badge/Maven-Build-red)
![Status](https://img.shields.io/badge/Status-Completed-success)

**A Java-based Smart Public Transportation Management System**
Built using **Java, Servlets, JSP, JDBC, MySQL, Maven, and Apache Tomcat**

</div>

---

# 📌 Project Overview

**SmartTransit** is a full-stack Java web application designed to improve public transportation management.

The system enables administrators and users to:

✅ Manage buses and routes
✅ Search buses by stop
✅ Track bus information dynamically
✅ Store and retrieve transit data using MySQL
✅ Perform real-time CRUD operations

The project follows the **MVC (Model-View-Controller)** architecture and demonstrates complete integration between frontend, backend, and database systems.

---

# 🚀 Features

### 🚌 Bus Management

* Add new buses
* Update bus details
* Delete buses
* View complete bus list

### 🛣 Route Management

* Create and manage routes
* Configure start point and destination
* Set fare and distance

### 📍 Stop Search

* Search buses available at a particular stop

### 📡 Bus Tracking

* Track buses dynamically through database records

### 🗄 Database Integration

* Real-time data storage using MySQL + JDBC

---

# 🏗 System Architecture

```text
                    ┌────────────────────┐
                    │      User UI       │
                    │   (JSP Pages)      │
                    └─────────┬──────────┘
                              │ HTTP Request
                              ▼
                    ┌────────────────────┐
                    │      Servlets      │
                    │ (Controller Layer) │
                    └─────────┬──────────┘
                              │
                              ▼
                    ┌────────────────────┐
                    │     DAO Layer      │
                    │ Database Handling  │
                    └─────────┬──────────┘
                              │ JDBC
                              ▼
                    ┌────────────────────┐
                    │      MySQL DB      │
                    │ smarttransit DB    │
                    └────────────────────┘
```

---

# 🔄 Request Flow Diagram

```text
User Action
     │
     ▼
JSP Page (Frontend)
     │
     ▼
Servlet Receives Request
     │
     ▼
DAO Executes SQL Query
     │
     ▼
MySQL Database
     │
     ▼
Result Returned
     │
     ▼
Servlet Processes Response
     │
     ▼
JSP Displays Updated Data
```

---

# 🧠 MVC Architecture Used

```text
MODEL
│
├── Bus.java
├── Route.java
└── Stop.java

VIEW
│
├── index.jsp
├── buses.jsp
├── routes.jsp
├── search.jsp
└── track.jsp

CONTROLLER
│
├── BusServlet.java
├── RouteServlet.java
├── SearchServlet.java
└── TrackServlet.java
```

---

# 🗃 Database Design

The project uses **MySQL Relational Database**.

### Main Tables

| Table Name   | Purpose                     |
| ------------ | --------------------------- |
| buses        | Stores bus information      |
| routes       | Stores route details        |
| stops        | Stores bus stop information |
| route_stops  | Maps routes with stops      |
| bus_location | Stores tracking data        |

### Database Relationship Flow

```text
Routes
   │
   ├── Multiple Buses
   │
   └── Multiple Stops

Stops
   │
   └── Connected via route_stops
```

---

# 🛠 Tech Stack

## Backend

* Java
* JDBC
* Servlets

## Frontend

* JSP
* HTML
* CSS
* JavaScript

## Database

* MySQL

## Tools & Server

* Apache Tomcat 9
* Maven
* VS Code

---

# 📂 Project Structure

```text
SmartTransit
│── pom.xml
│── README.md
│
├── sql
│   └── schema.sql
│
├── src/main
│   ├── java/com/smarttransit
│   │   ├── dao
│   │   ├── model
│   │   ├── servlet
│   │   └── util
│   │
│   └── webapp
│       ├── css
│       ├── js
│       ├── WEB-INF
│       ├── index.jsp
│       ├── buses.jsp
│       ├── routes.jsp
│       ├── search.jsp
│       └── track.jsp
```

---

# ⚙ Installation & Setup

### Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/SmartTransit.git
cd SmartTransit
```

### Configure Database

1. Create MySQL database:

```sql
CREATE DATABASE smarttransit;
```

2. Run schema:

```sql
source sql/schema.sql;
```

### Configure Database Password

Update:

```text
DBConnection.java
```

with your MySQL credentials.

---

### Build Project

```bash
mvn clean package
```

---

### Deploy on Apache Tomcat

Copy generated WAR:

```text
target/SmartTransit.war
```

to:

```text
Tomcat/webapps/
```

Start Tomcat and open:

```text
http://localhost:8080/SmartTransit
```

---

# 🧪 Testing

✔ CRUD Operations Tested
✔ Database Connectivity Verified
✔ Servlet Request Mapping Tested
✔ WAR Deployment Verified
✔ MySQL Data Persistence Tested

---

# 🚧 Challenges Faced

* Apache Tomcat deployment issues
* WAR packaging errors
* MySQL JDBC configuration
* Servlet mapping debugging
* Maven dependency management

---

# 🔮 Future Enhancements

* GPS-based live tracking
* Login & Authentication
* Admin Dashboard
* Real-time notifications
* Spring Boot migration
* REST APIs integration

---

# 👩‍💻 Author

**Anshika Tiwari**
Computer Science Engineering Student
Cybersecurity • Java Full Stack • Problem Solving

---

### ⭐ If you found this project useful, give it a star!
