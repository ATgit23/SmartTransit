<%-- ════════════════════════════════════
     FILE: track.jsp
     ════════════════════════════════════ --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Track — SmartTransit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="app-context" data-ctx="${pageContext.request.contextPath}"></div>

<nav class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/">🚌 SmartTransit</a>
    <a href="${pageContext.request.contextPath}/">Dashboard</a>
    <a href="${pageContext.request.contextPath}/buses">Buses</a>
    <a href="${pageContext.request.contextPath}/routes">Routes</a>
    <a href="${pageContext.request.contextPath}/search.jsp">Search</a>
    <a href="${pageContext.request.contextPath}/track.jsp" class="active">Track</a>
</nav>

<div class="container">
    <div class="page-header"><h2>📍 Real-Time Bus Tracker</h2></div>

    <div class="card">
        <p style="margin-bottom:.75rem;color:var(--muted)">
            Bus number enter karein track karne ke liye, ya
            blank chhod dein sabhi buses dekhne ke liye.
        </p>
        <div class="search-bar">
            <input type="text" id="trackInput"
                   placeholder="Bus number e.g. MP04 PA 1234  (ya blank chhod dein)">
            <button class="btn btn-primary" id="trackBtn">📍 Track</button>
        </div>
        <p class="refresh-note">🔄 Data har 15 seconds mein automatically refresh hota hai.</p>
        <div id="trackLoader">⏳ Location fetch ho rahi hai...</div>
    </div>

    <div id="trackResult"></div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>