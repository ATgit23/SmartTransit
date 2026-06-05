package com.smarttransit.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * SETUP INSTRUCTIONS:
 * 1. Copy/rename this file to DBConnection.java
 * 2. Replace DB_USER and DB_PASS with your MySQL credentials
 * 3. Never commit DBConnection.java to GitHub
 */
 class DBConnectionexample{

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/smarttransit?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "xyz";   // ← change karo
    private static final String DB_PASS = "abcd";   // ← change karo

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    public static void close(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}