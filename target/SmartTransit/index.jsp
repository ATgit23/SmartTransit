<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.smarttransit.dao.*,java.util.*" %>
<%
    BusDAO   busDAO   = new BusDAO();
    RouteDAO routeDAO = new RouteDAO();
    StopDAO  stopDAO  = new StopDAO();
    int totalBuses  = busDAO.getAllBuses().size();
    int totalRoutes = routeDAO.getAllRoutes().size();
    int totalStops  = stopDAO.getAllStops().size();
    long activeBuses = busDAO.getAllBuses().stream()
        .filter(b -> "ACTIVE".equals(b.getStatus())).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SmartTransit — Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="app-context" data-ctx="${pageContext.request.contextPath}"></div>

<nav class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/">🚌 SmartTransit</a>
    <a href="${pageContext.request.contextPath}/" class="active">Dashboard</a>
    <a href="${pageContext.request.contextPath}/buses">Buses</a>
    <a href="${pageContext.request.contextPath}/routes">Routes</a>
    <a href="${pageContext.request.contextPath}/search.jsp">Search</a>
    <a href="${pageContext.request.contextPath}/track.jsp">Track</a>
</nav>

<div class="container">

    <div class="hero">
        <h1>🚌 SmartTransit</h1>
        <p>Bhopal Transportation Management System — Routes, Buses aur Real-Time Tracking</p>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-num"><%= totalBuses %></div>
            <div class="stat-label">Total Buses</div>
        </div>
        <div class="stat-card">
            <div class="stat-num"><%= activeBuses %></div>
            <div class="stat-label">Active Buses</div>
        </div>
        <div class="stat-card">
            <div class="stat-num"><%= totalRoutes %></div>
            <div class="stat-label">Total Routes</div>
        </div>
        <div class="stat-card">
            <div class="stat-num"><%= totalStops %></div>
            <div class="stat-label">Total Stops</div>
        </div>
    </div>

    <div class="card">
        <h3>⚡ Quick Actions</h3>
        <div class="quick-links">
            <a href="${pageContext.request.contextPath}/buses?action=add"  class="btn btn-primary">+ Add Bus</a>
            <a href="${pageContext.request.contextPath}/routes?action=add" class="btn btn-success">+ Add Route</a>
            <a href="${pageContext.request.contextPath}/search.jsp"        class="btn btn-warning">🔍 Search by Stop</a>
            <a href="${pageContext.request.contextPath}/track.jsp"         class="btn btn-primary">📍 Track Bus</a>
        </div>
    </div>

</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>