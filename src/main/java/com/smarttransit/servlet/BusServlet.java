// ══════════════════════════════════════════
// FILE 1: servlet/BusServlet.java
// ══════════════════════════════════════════
package com.smarttransit.servlet;

import com.smarttransit.dao.BusDAO;
import com.smarttransit.dao.RouteDAO;
import com.smarttransit.model.Bus;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/buses")
public class BusServlet extends HttpServlet {

    private final BusDAO   busDAO   = new BusDAO();
    private final RouteDAO routeDAO = new RouteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        try {
            switch (action) {
                case "add"    -> showForm(req, resp, null);
                case "edit"   -> showForm(req, resp,
                                    busDAO.getBusById(Integer.parseInt(req.getParameter("id"))));
                case "delete" -> { busDAO.deleteBus(Integer.parseInt(req.getParameter("id")));
                                   resp.sendRedirect(req.getContextPath() + "/buses"); }
                default       -> listBuses(req, resp);
            }
        } catch (Exception e) { throw new ServletException(e); }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Bus bus = new Bus();
            String action = req.getParameter("action");
            if ("edit".equals(action))
                bus.setBusId(Integer.parseInt(req.getParameter("busId")));
            bus.setBusNumber(req.getParameter("busNumber").trim());
            bus.setCapacity (Integer.parseInt(req.getParameter("capacity")));
            bus.setStatus   (req.getParameter("status"));
            bus.setRouteId  (Integer.parseInt(req.getParameter("routeId")));

            if ("edit".equals(action)) busDAO.updateBus(bus);
            else                       busDAO.addBus(bus);

            resp.sendRedirect(req.getContextPath() + "/buses");
        } catch (Exception e) { throw new ServletException(e); }
    }

    private void listBuses(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        req.setAttribute("buses",  busDAO.getAllBuses());
        req.setAttribute("routes", routeDAO.getAllRoutes());
        req.getRequestDispatcher("/buses.jsp").forward(req, resp);
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp, Bus editBus)
            throws Exception {
        req.setAttribute("editBus", editBus);
        req.setAttribute("buses",   busDAO.getAllBuses());
        req.setAttribute("routes",  routeDAO.getAllRoutes());
        req.getRequestDispatcher("/buses.jsp").forward(req, resp);
    }
}