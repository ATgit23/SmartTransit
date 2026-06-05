package com.smarttransit.dao;

import com.smarttransit.model.Bus;
import com.smarttransit.model.Stop;
import com.smarttransit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StopDAO {

    public List<Stop> getAllStops() throws SQLException {
        List<Stop> list = new ArrayList<>();
        String sql = "SELECT * FROM stops ORDER BY stop_name";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public List<Bus> getBusesByStop(String stopName) throws SQLException {
        List<Bus> list = new ArrayList<>();
        String sql = "SELECT DISTINCT b.bus_id, b.bus_number, b.capacity, b.status, " +
                     "b.route_id, r.route_name, bl.current_stop " +
                     "FROM stops s " +
                     "JOIN route_stops rs ON s.stop_id = rs.stop_id " +
                     "JOIN routes r ON rs.route_id = r.route_id " +
                     "JOIN buses b ON b.route_id = r.route_id " +
                     "LEFT JOIN bus_location bl ON b.bus_id = bl.bus_id " +
                     "WHERE s.stop_name LIKE ? " +
                     "ORDER BY b.bus_number";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + stopName + "%");
            try (ResultSet rs2 = ps.executeQuery()) {
                while (rs2.next()) {
                    Bus b = new Bus();
                    b.setBusId      (rs2.getInt   ("bus_id"));
                    b.setBusNumber  (rs2.getString("bus_number"));
                    b.setCapacity   (rs2.getInt   ("capacity"));
                    b.setStatus     (rs2.getString("status"));
                    b.setRouteId    (rs2.getInt   ("route_id"));
                    b.setRouteName  (rs2.getString("route_name"));
                    b.setCurrentStop(rs2.getString("current_stop"));
                    list.add(b);
                }
            }
        }
        return list;
    }

    private Stop mapRow(ResultSet rs) throws SQLException {
        return new Stop(
            rs.getInt   ("stop_id"),
            rs.getString("stop_name"),
            rs.getString("location")
        );
    }
}