// ══════════════════════════════════════════
// FILE 4: servlet/TrackServlet.java
// ══════════════════════════════════════════
package com.smarttransit.servlet;

import com.google.gson.Gson;
import com.smarttransit.dao.BusDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/track")
public class TrackServlet extends HttpServlet {

    private final BusDAO busDAO = new BusDAO();
    private final Gson   gson   = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String busNumber = req.getParameter("bus");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            if (busNumber == null || busNumber.isBlank())
                resp.getWriter().write(gson.toJson(busDAO.getAllBuses()));
            else
                resp.getWriter().write(gson.toJson(busDAO.searchByBusNumber(busNumber.trim())));
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}