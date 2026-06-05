package com.smarttransit.dao;

import com.smarttransit.model.Bus;
import com.smarttransit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BusDAO {

    public List<Bus> getAllBuses() throws SQLException {
        List<Bus> list = new ArrayList<>();
        String sql = "SELECT b.bus_id, b.bus_number, b.capacity, b.status, b.route_id, " +
                     "r.route_name, bl.current_stop " +
                     "FROM buses b " +
                     "LEFT JOIN routes r ON b.route_id = r.route_id " +
                     "LEFT JOIN bus_location bl ON b.bus_id = bl.bus_id " +
                     "ORDER BY b.bus_id";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public Bus getBusById(int busId) throws SQLException {
        String sql = "SELECT b.bus_id, b.bus_number, b.capacity, b.status, b.route_id, " +
                     "r.route_name, bl.current_stop " +
                     "FROM buses b " +
                     "LEFT JOIN routes r ON b.route_id = r.route_id " +
                     "LEFT JOIN bus_location bl ON b.bus_id = bl.bus_id " +
                     "WHERE b.bus_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, busId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    public boolean addBus(Bus bus) throws SQLException {
        String sql = "INSERT INTO buses (bus_number, capacity, status, route_id) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bus.getBusNumber());
            ps.setInt   (2, bus.getCapacity());
            ps.setString(3, bus.getStatus());
            ps.setInt   (4, bus.getRouteId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateBus(Bus bus) throws SQLException {
        String sql = "UPDATE buses SET bus_number=?, capacity=?, status=?, route_id=? WHERE bus_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bus.getBusNumber());
            ps.setInt   (2, bus.getCapacity());
            ps.setString(3, bus.getStatus());
            ps.setInt   (4, bus.getRouteId());
            ps.setInt   (5, bus.getBusId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteBus(int busId) throws SQLException {
        String sql = "DELETE FROM buses WHERE bus_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, busId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Bus> searchByBusNumber(String keyword) throws SQLException {
        List<Bus> list = new ArrayList<>();
        String sql = "SELECT b.bus_id, b.bus_number, b.capacity, b.status, b.route_id, " +
                     "r.route_name, bl.current_stop " +
                     "FROM buses b " +
                     "LEFT JOIN routes r ON b.route_id = r.route_id " +
                     "LEFT JOIN bus_location bl ON b.bus_id = bl.bus_id " +
                     "WHERE b.bus_number LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    private Bus mapRow(ResultSet rs) throws SQLException {
        Bus b = new Bus();
        b.setBusId      (rs.getInt   ("bus_id"));
        b.setBusNumber  (rs.getString("bus_number"));
        b.setCapacity   (rs.getInt   ("capacity"));
        b.setStatus     (rs.getString("status"));
        b.setRouteId    (rs.getInt   ("route_id"));
        b.setRouteName  (rs.getString("route_name"));
        b.setCurrentStop(rs.getString("current_stop"));
        return b;
    }
}
