<%-- ════════════════════════════════════
     FILE: search.jsp
     ════════════════════════════════════ --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.smarttransit.dao.StopDAO,com.smarttransit.model.Stop,java.util.List" %>
<%
    StopDAO       stopDAO2 = new StopDAO();
    List<Stop> allStops    = stopDAO2.getAllStops();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Search — SmartTransit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="app-context" data-ctx="${pageContext.request.contextPath}"></div>

<nav class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/">🚌 SmartTransit</a>
    <a href="${pageContext.request.contextPath}/">Dashboard</a>
    <a href="${pageContext.request.contextPath}/buses">Buses</a>
    <a href="${pageContext.request.contextPath}/routes">Routes</a>
    <a href="${pageContext.request.contextPath}/search.jsp" class="active">Search</a>
    <a href="${pageContext.request.contextPath}/track.jsp">Track</a>
</nav>

<div class="container">
    <div class="page-header"><h2>🔍 Stop se Bus Dhundein</h2></div>

    <div class="card">
        <p style="margin-bottom:1rem;color:var(--muted)">
            Stop ka naam type karein — jaise <strong>New Market</strong>,
            <strong>Char Imli</strong>, <strong>DB Mall</strong> — aur
            us stop se guzarne wali saari buses dekhein.
        </p>
        <div class="search-bar">
            <input type="text" id="searchInput"
                   placeholder="Stop name type karein... e.g. Char Imli"
                   list="stopsList">
            <datalist id="stopsList">
                <% for (Stop s : allStops) { %>
                    <option value="<%= s.getStopName() %>">
                <% } %>
            </datalist>
            <button class="btn btn-primary" id="searchBtn">🔍 Search</button>
        </div>
        <div id="loader">⏳ Buses dhundhi ja rahi hain...</div>
        <div id="searchResult"></div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>