<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.smarttransit.model.*,com.smarttransit.dao.*,java.util.*" %>
<%
    BusDAO   busDAO2   = new BusDAO();
    RouteDAO routeDAO2 = new RouteDAO();
    List<Bus>   buses   = (List<Bus>)   request.getAttribute("buses");
    List<Route> routes2 = (List<Route>) request.getAttribute("routes");
    Bus editBus         = (Bus)         request.getAttribute("editBus");
    if (buses   == null) buses   = busDAO2.getAllBuses();
    if (routes2 == null) routes2 = routeDAO2.getAllRoutes();
    boolean showForm = "add".equals(request.getParameter("action")) || editBus != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Buses — SmartTransit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="app-context" data-ctx="${pageContext.request.contextPath}"></div>

<nav class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/">🚌 SmartTransit</a>
    <a href="${pageContext.request.contextPath}/">Dashboard</a>
    <a href="${pageContext.request.contextPath}/buses" class="active">Buses</a>
    <a href="${pageContext.request.contextPath}/routes">Routes</a>
    <a href="${pageContext.request.contextPath}/search.jsp">Search</a>
    <a href="${pageContext.request.contextPath}/track.jsp">Track</a>
</nav>

<div class="container">
    <div class="page-header">
        <h2>🚌 Bus Management</h2>
        <a href="${pageContext.request.contextPath}/buses?action=add" class="btn btn-primary">+ Add Bus</a>
    </div>

    <% if (showForm) { %>
    <div class="card">
        <h3><%= editBus != null ? "✏️ Edit Bus" : "➕ Add New Bus" %></h3>
        <form method="post" action="${pageContext.request.contextPath}/buses">
            <input type="hidden" name="action" value="<%= editBus != null ? "edit" : "add" %>">
            <% if (editBus != null) { %>
                <input type="hidden" name="busId" value="<%= editBus.getBusId() %>">
            <% } %>
            <div class="form-grid">
                <div class="form-group">
                    <label>Bus Number (e.g. MP04 PA 1234)</label>
                    <input type="text" name="busNumber" required maxlength="20"
                           value="<%= editBus != null ? editBus.getBusNumber() : "" %>"
                           placeholder="MP04 XX 0000">
                </div>
                <div class="form-group">
                    <label>Capacity (Seats)</label>
                    <input type="number" name="capacity" min="1" max="200" required
                           value="<%= editBus != null ? editBus.getCapacity() : 40 %>">
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="status" required>
                        <% for (String s : new String[]{"ACTIVE","INACTIVE","MAINTENANCE"}) {
                               boolean sel = editBus != null && s.equals(editBus.getStatus()); %>
                        <option value="<%= s %>" <%= sel ? "selected" : "" %>><%= s %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label>Assign Route</label>
                    <select name="routeId" required>
                        <% for (Route r : routes2) {
                               boolean sel = editBus != null && r.getRouteId() == editBus.getRouteId(); %>
                        <option value="<%= r.getRouteId() %>" <%= sel ? "selected" : "" %>>
                            <%= r.getRouteName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-success">
                    <%= editBus != null ? "✅ Update Bus" : "✅ Save Bus" %>
                </button>
                <a href="${pageContext.request.contextPath}/buses" class="btn btn-danger">✖ Cancel</a>
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
                        <th>Bus Number</th>
                        <th>Route</th>
                        <th>Capacity</th>
                        <th>Status</th>
                        <th>Current Stop</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% if (buses.isEmpty()) { %>
                    <tr><td colspan="7" style="text-align:center;padding:2rem;color:#999">
                        Koi bus nahi mili.
                    </td></tr>
                <% } else {
                       int i = 1;
                       for (Bus b : buses) {
                           String bc = "ACTIVE".equals(b.getStatus())      ? "badge-active"
                                     : "MAINTENANCE".equals(b.getStatus()) ? "badge-maintenance"
                                                                            : "badge-inactive";
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><strong><%= b.getBusNumber() %></strong></td>
                        <td><%= b.getRouteName()   != null ? b.getRouteName()   : "—" %></td>
                        <td><%= b.getCapacity() %></td>
                        <td><span class="badge <%= bc %>"><%= b.getStatus() %></span></td>
                        <td><%= b.getCurrentStop() != null ? b.getCurrentStop() : "—" %></td>
                        <td style="display:flex;gap:.4rem;flex-wrap:wrap;">
                            <a href="${pageContext.request.contextPath}/buses?action=edit&id=<%= b.getBusId() %>"
                               class="btn btn-warning btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/buses?action=delete&id=<%= b.getBusId() %>"
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