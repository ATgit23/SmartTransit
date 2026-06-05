// ══════════════════════════════════════════
// FILE 2: servlet/RouteServlet.java
// ══════════════════════════════════════════
package com.smarttransit.servlet;

import com.smarttransit.dao.RouteDAO;
import com.smarttransit.model.Route;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/routes")
public class RouteServlet extends HttpServlet {

    private final RouteDAO routeDAO = new RouteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        try {
            switch (action) {
                case "edit"   -> showForm(req, resp,
                                    routeDAO.getRouteById(Integer.parseInt(req.getParameter("id"))));
                case "delete" -> { routeDAO.deleteRoute(Integer.parseInt(req.getParameter("id")));
                                   resp.sendRedirect(req.getContextPath() + "/routes"); }
                default       -> listRoutes(req, resp);
            }
        } catch (Exception e) { throw new ServletException(e); }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Route r = new Route();
            String action = req.getParameter("action");
            if ("edit".equals(action))
                r.setRouteId(Integer.parseInt(req.getParameter("routeId")));
            r.setRouteName (req.getParameter("routeName").trim());
            r.setStartPoint(req.getParameter("startPoint").trim());
            r.setEndPoint  (req.getParameter("endPoint").trim());
            r.setDistanceKm(Double.parseDouble(req.getParameter("distanceKm")));
            r.setFare      (Double.parseDouble(req.getParameter("fare")));

            if ("edit".equals(action)) routeDAO.updateRoute(r);
            else                       routeDAO.addRoute(r);

            resp.sendRedirect(req.getContextPath() + "/routes");
        } catch (Exception e) { throw new ServletException(e); }
    }

    private void listRoutes(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setAttribute("routes", routeDAO.getAllRoutes());
        req.getRequestDispatcher("/routes.jsp").forward(req, resp);
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp, Route editRoute)
            throws Exception {
        req.setAttribute("editRoute", editRoute);
        req.setAttribute("routes",    routeDAO.getAllRoutes());
        req.getRequestDispatcher("/routes.jsp").forward(req, resp);
    }
}