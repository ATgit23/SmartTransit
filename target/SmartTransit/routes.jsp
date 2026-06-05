<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.smarttransit.model.*,com.smarttransit.dao.*,java.util.*" %>
<%
    RouteDAO routeDAO3 = new RouteDAO();
    List<Route> routes3  = (List<Route>) request.getAttribute("routes");
    Route editRoute      = (Route)       request.getAttribute("editRoute");
    if (routes3 == null) routes3 = routeDAO3.getAllRoutes();
    boolean showForm3 = "add".equals(request.getParameter("action")) || editRoute != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Routes — SmartTransit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="app-context" data-ctx="${pageContext.request.contextPath}"></div>

<nav class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/">🚌 SmartTransit</a>
    <a href="${pageContext.request.contextPath}/">Dashboard</a>
    <a href="${pageContext.request.contextPath}/buses">Buses</a>
    <a href="${pageContext.request.contextPath}/routes" class="active">Routes</a>
    <a href="${pageContext.request.contextPath}/search.jsp">Search</a>
    <a href="${pageContext.request.contextPath}/track.jsp">Track</a>
</nav>

<div class="container">
    <div class="page-header">
        <h2>🗺️ Route Management</h2>
        <a href="${pageContext.request.contextPath}/routes?action=add" class="btn btn-primary">+ Add Route</a>
    </div>

    <% if (showForm3) { %>
    <div class="card">
        <h3><%= editRoute != null ? "✏️ Edit Route" : "➕ Add New Route" %></h3>
        <form method="post" action="${pageContext.request.contextPath}/routes">
            <input type="hidden" name="action" value="<%= editRoute != null ? "edit" : "add" %>">
            <% if (editRoute != null) { %>
                <input type="hidden" name="routeId" value="<%= editRoute.getRouteId() %>">
            <% } %>
            <div class="form-grid">
                <div class="form-group">
                    <label>Route Name</label>
                    <input type="text" name="routeName" required
                           value="<%= editRoute != null ? editRoute.getRouteName() : "" %>"
                           placeholder="e.g. Route 6 - Karond to Misrod">
                </div>
                <div class="form-group">
                    <label>Start Point</label>
                    <input type="text" name="startPoint" required
                           value="<%= editRoute != null ? editRoute.getStartPoint() : "" %>"
                           placeholder="e.g. Karond Chouraha">
                </div>
                <div class="form-group">
                    <label>End Point</label>
                    <input type="text" name="endPoint" required
                           value="<%= editRoute != null ? editRoute.getEndPoint() : "" %>"
                           placeholder="e.g. Misrod">
                </div>
                <div class="form-group">
                    <label>Distance (km)</label>
                    <input type="number" name="distanceKm" step="0.01" min="0"
                           value="<%= editRoute != null ? editRoute.getDistanceKm() : "" %>"
                           placeholder="e.g. 18.5">
                </div>
                <div class="form-group">
                    <label>Fare (₹)</label>
                    <input type="number" name="fare" step="0.01" min="0" required
                           value="<%= editRoute != null ? editRoute.getFare() : "" %>"
                           placeholder="e.g. 20">
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-success">
                    <%= editRoute != null ? "✅ Update Route" : "✅ Save Route" %>
                </button>
                <a href="${pageContext.request.contextPath}/routes" class="btn btn-danger">✖ Cancel</a>
            </div>
        </form>
    </div>
    <% } %>

    <div class="card">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Route Name</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Distance</th>
                        <th>Fare (₹)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% if (routes3.isEmpty()) { %>
                    <tr><td colspan="7" style="text-align:center;padding:2rem;color:#999">
                        Koi route nahi mila.
                    </td></tr>
                <% } else {
                       int i = 1;
                       for (Route r : routes3) { %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><strong><%= r.getRouteName() %></strong></td>
                        <td><%= r.getStartPoint() %></td>
                        <td><%= r.getEndPoint() %></td>
                        <td><%= r.getDistanceKm() %> km</td>
                        <td>₹ <%= r.getFare() %></td>
                        <td style="display:flex;gap:.4rem;flex-wrap:wrap;">
                            <a href="${pageContext.request.contextPath}/routes?action=edit&id=<%= r.getRouteId() %>"
                               class="btn btn-warning btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/routes?action=delete&id=<%= r.getRouteId() %>"
                               class="btn btn-danger btn-sm btn-delete">Delete</a>
                        </td>
                    </tr>
                <% }} %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>