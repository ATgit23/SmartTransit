package com.smarttransit.dao;

import com.smarttransit.model.Route;
import com.smarttransit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RouteDAO {

    public List<Route> getAllRoutes() throws SQLException {
        List<Route> list = new ArrayList<>();
        String sql = "SELECT * FROM routes ORDER BY route_id";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public Route getRouteById(int routeId) throws SQLException {
        String sql = "SELECT * FROM routes WHERE route_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    public boolean addRoute(Route r) throws SQLException {
        String sql = "INSERT INTO routes (route_name, start_point, end_point, distance_km, fare) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getRouteName());
            ps.setString(2, r.getStartPoint());
            ps.setString(3, r.getEndPoint());
            ps.setDouble(4, r.getDistanceKm());
            ps.setDouble(5, r.getFare());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateRoute(Route r) throws SQLException {
        String sql = "UPDATE routes SET route_name=?, start_point=?, end_point=?, distance_km=?, fare=? WHERE route_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getRouteName());
            ps.setString(2, r.getStartPoint());
            ps.setString(3, r.getEndPoint());
            ps.setDouble(4, r.getDistanceKm());
            ps.setDouble(5, r.getFare());
            ps.setInt   (6, r.getRouteId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteRoute(int routeId) throws SQLException {
        String sql = "DELETE FROM routes WHERE route_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            return ps.executeUpdate() > 0;
        }
    }

    private Route mapRow(ResultSet rs) throws SQLException {
        Route r = new Route();
        r.setRouteId   (rs.getInt   ("route_id"));
        r.setRouteName (rs.getString("route_name"));
        r.setStartPoint(rs.getString("start_point"));
        r.setEndPoint  (rs.getString("end_point"));
        r.setDistanceKm(rs.getDouble("distance_km"));
        r.setFare      (rs.getDouble("fare"));
        return r;
    }
}
