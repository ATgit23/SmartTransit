// ══════════════════════════════════════════
// FILE 3: servlet/SearchServlet.java
// ══════════════════════════════════════════
package com.smarttransit.servlet;

import com.google.gson.Gson;
import com.smarttransit.dao.StopDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private final StopDAO stopDAO = new StopDAO();
    private final Gson    gson    = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String stopName = req.getParameter("stop");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (stopName == null || stopName.isBlank()) {
            resp.getWriter().write("[]");
            return;
        }
        try {
            resp.getWriter().write(gson.toJson(stopDAO.getBusesByStop(stopName.trim())));
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}