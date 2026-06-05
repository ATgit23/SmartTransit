# 🚌 SmartTransit — Transportation Management System

> Developed a backend-driven transportation management system using Java, JDBC, SQL, JSP, and Servlets.  
> Designed optimized database queries and modular OOP architecture for efficient route and transport management.

---

## 🛠️ Tech Stack

| Layer      | Technology                          |
|------------|-------------------------------------|
| Frontend   | HTML5, CSS3, JavaScript (AJAX)      |
| Backend    | Java, Servlets, JSP, JSTL           |
| Database   | MySQL 8.x via JDBC                  |
| Build Tool | Apache Maven                        |
| Server     | Apache Tomcat 9.x                   |

---

## ✨ Features

- **Bus Management** — Add, Edit, Delete buses with Indian registration numbers (MP04 series)
- **Route Management** — Manage Bhopal city routes with distance and fare
- **Search by Stop** — AJAX-powered real-time search for buses at any Bhopal stop
- **Live Bus Tracker** — Auto-refreshing tracker (every 15 seconds) for real-time bus location
- **Responsive UI** — Clean, mobile-friendly interface

---

## 🗺️ Bhopal Routes Covered

| Route | From | To |
|-------|------|----|
| Route 1 | ISBT Nadra Bus Stand | Raja Bhoj Airport |
| Route 2 | New Market | Mandideep Industrial Area |
| Route 3 | Habibganj Railway Station | Berasia |
| Route 4 | MP Nagar Zone 1 | Misrod |
| Route 5 | Karond Chouraha | Hoshangabad Road |

---

## 📁 Project Structure

```
SmartTransit/
├── src/main/java/com/smarttransit/
│   ├── dao/        → BusDAO, RouteDAO, StopDAO
│   ├── model/      → Bus, Route, Stop
│   ├── servlet/    → BusServlet, RouteServlet, SearchServlet, TrackServlet
│   └── util/       → DBConnection
├── src/main/webapp/
│   ├── WEB-INF/web.xml
│   ├── css/style.css
│   ├── js/main.js
│   ├── index.jsp
│   ├── buses.jsp
│   ├── routes.jsp
│   ├── search.jsp
│   └── track.jsp
├── sql/schema.sql
├── pom.xml
└── README.md
```

---

## ⚙️ Setup Instructions

### Prerequisites
- Java 17+
- MySQL 8.x
- Apache Maven 3.6+
- Apache Tomcat 9.x

### Step 1 — Database Setup
```bash
mysql -u root -p < sql/schema.sql
```

### Step 2 — Configure DB Credentials
```bash
# Copy example file
copy src\main\java\com\smarttransit\util\DBConnection.example.java
     src\main\java\com\smarttransit\util\DBConnection.java

# Edit DBConnection.java — set your MySQL username & password
```

### Step 3 — Build
```bash
mvn clean package
```

### Step 4 — Deploy
```bash
copy target\SmartTransit.war <TOMCAT_HOME>\webapps\
# Start Tomcat
```

### Step 5 — Access
```
http://localhost:8080/SmartTransit/
```

---

## 🔗 API Endpoints

| URL | Method | Description |
|-----|--------|-------------|
| `/buses` | GET | List / CRUD buses |
| `/routes` | GET | List / CRUD routes |
| `/search?stop=Char Imli` | GET | JSON: buses at stop |
| `/track?bus=MP04 PA 1234` | GET | JSON: bus location |
| `/track` | GET | JSON: all buses |

---

## 👤 Author

**Your Name**  
B.Tech Computer Science  
[GitHub](https://github.com/yourusername) · [LinkedIn](https://linkedin.com/in/yourprofile)

---

## 📄 License
MIT License — free to use and modify.