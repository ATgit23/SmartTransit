-- ═══════════════════════════════════════════════════
--  SmartTransit — Complete Database Schema
--  City: Bhopal, Madhya Pradesh
--  Run: mysql -u root -p < schema.sql
-- ═══════════════════════════════════════════════════

CREATE DATABASE IF NOT EXISTS smarttransit;
USE smarttransit;

-- ─────────────────────────────────────────
-- STEP 1: DROP TABLES (safe re-run)
-- ─────────────────────────────────────────
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS bus_location;
DROP TABLE IF EXISTS route_stops;
DROP TABLE IF EXISTS buses;
DROP TABLE IF EXISTS stops;
DROP TABLE IF EXISTS routes;

SET FOREIGN_KEY_CHECKS = 1;

-- ─────────────────────────────────────────
-- STEP 2: CREATE TABLES
-- ─────────────────────────────────────────

CREATE TABLE routes (
    route_id    INT AUTO_INCREMENT PRIMARY KEY,
    route_name  VARCHAR(100) NOT NULL,
    start_point VARCHAR(100) NOT NULL,
    end_point   VARCHAR(100) NOT NULL,
    distance_km DECIMAL(6,2),
    fare        DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stops (
    stop_id    INT AUTO_INCREMENT PRIMARY KEY,
    stop_name  VARCHAR(100) NOT NULL,
    location   VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE buses (
    bus_id     INT AUTO_INCREMENT PRIMARY KEY,
    bus_number VARCHAR(20)  NOT NULL UNIQUE,
    capacity   INT          NOT NULL DEFAULT 40,
    status     ENUM('ACTIVE','INACTIVE','MAINTENANCE') NOT NULL DEFAULT 'ACTIVE',
    route_id   INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bus_route
        FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE SET NULL
);

CREATE TABLE route_stops (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    route_id     INT NOT NULL,
    stop_id      INT NOT NULL,
    stop_order   INT NOT NULL,
    arrival_time TIME,
    FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    FOREIGN KEY (stop_id)  REFERENCES stops(stop_id)   ON DELETE CASCADE,
    UNIQUE KEY unique_route_stop (route_id, stop_id)
);

CREATE TABLE bus_location (
    location_id  INT AUTO_INCREMENT PRIMARY KEY,
    bus_id       INT NOT NULL UNIQUE,
    current_stop VARCHAR(100),
    latitude     DECIMAL(10,7),
    longitude    DECIMAL(10,7),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE CASCADE
);

-- ─────────────────────────────────────────
-- STEP 3: SEED DATA — ROUTES (Bhopal)
-- ─────────────────────────────────────────

INSERT INTO routes (route_name, start_point, end_point, distance_km, fare) VALUES
('Route 1 - ISBT to Airport',         'ISBT Nadra Bus Stand',      'Raja Bhoj Airport',         18.50, 25.00),
('Route 2 - New Market to Mandideep', 'New Market',                'Mandideep Industrial Area', 32.00, 35.00),
('Route 3 - Habibganj to Berasia',    'Habibganj Railway Station', 'Berasia',                   38.00, 40.00),
('Route 4 - MP Nagar to Misrod',      'MP Nagar Zone 1',           'Misrod',                    22.00, 20.00),
('Route 5 - Karond to Hoshangabad',   'Karond Chouraha',           'Hoshangabad Road',          15.00, 15.00);

-- ─────────────────────────────────────────
-- STEP 4: SEED DATA — STOPS (Bhopal)
-- ─────────────────────────────────────────

INSERT INTO stops (stop_name, location) VALUES
('ISBT Nadra Bus Stand',       'Nadra, Old Bhopal'),
('Hamidia Road',               'Near Hamidia Hospital'),
('New Market',                 'TT Nagar, Bhopal'),
('Roshanpura Chouraha',        'Roshanpura, Bhopal'),
('MP Nagar Zone 1',            'MP Nagar, Bhopal'),
('Habibganj Railway Station',  'Habibganj, Bhopal'),
('DB Mall',                    'Arera Colony, Bhopal'),
('Hoshangabad Road',           'Near Piplani, Bhopal'),
('Misrod',                     'Misrod, Bhopal'),
('Karond Chouraha',            'Karond, Bhopal'),
('Char Imli',                  'Char Imli, Bhopal'),
('Bittan Market',              'Bittan Market, Bhopal'),
('Ayodhya Bypass',             'Ayodhya Nagar, Bhopal'),
('Raja Bhoj Airport',          'Bairagarh, Bhopal'),
('Bairagarh Chouraha',         'Bairagarh, Bhopal'),
('Berasia',                    'Berasia, Bhopal'),
('Mandideep Industrial Area',  'Mandideep, Raisen'),
('Piplani',                    'Piplani, Bhopal'),
('Bhopal Junction',            'Bhopal Railway Station'),
('Lalghati',                   'Lalghati, Bhopal');

-- ─────────────────────────────────────────
-- STEP 5: SEED DATA — BUSES (MP04 Series)
-- ─────────────────────────────────────────

INSERT INTO buses (bus_number, capacity, status, route_id) VALUES
('MP04 PA 1234', 45, 'ACTIVE',       1),
('MP04 PA 1235', 40, 'ACTIVE',       1),
('MP04 KB 5678', 50, 'ACTIVE',       2),
('MP04 KB 5679', 45, 'MAINTENANCE',  2),
('MP04 NA 9101', 55, 'ACTIVE',       3),
('MP04 NA 9102', 40, 'INACTIVE',     3),
('MP04 ZA 3456', 45, 'ACTIVE',       4),
('MP04 ZA 3457', 50, 'ACTIVE',       4),
('MP04 CA 7890', 40, 'ACTIVE',       5),
('MP04 CA 7891', 45, 'MAINTENANCE',  5);

-- ─────────────────────────────────────────
-- STEP 6: SEED DATA — ROUTE STOPS
-- ─────────────────────────────────────────

-- Route 1: ISBT Nadra → Hamidia → Roshanpura → Char Imli → Bairagarh → Airport
INSERT INTO route_stops (route_id, stop_id, stop_order, arrival_time) VALUES
(1,  1, 1, '06:00:00'),
(1,  2, 2, '06:15:00'),
(1,  4, 3, '06:30:00'),
(1, 11, 4, '06:50:00'),
(1, 15, 5, '07:10:00'),
(1, 14, 6, '07:30:00');

-- Route 2: New Market → MP Nagar → DB Mall → Piplani → Mandideep
INSERT INTO route_stops (route_id, stop_id, stop_order, arrival_time) VALUES
(2,  3, 1, '07:00:00'),
(2,  5, 2, '07:20:00'),
(2,  7, 3, '07:45:00'),
(2, 18, 4, '08:10:00'),
(2, 17, 5, '09:00:00');

-- Route 3: Habibganj → Bhopal Junction → Lalghati → Ayodhya Bypass → Berasia
INSERT INTO route_stops (route_id, stop_id, stop_order, arrival_time) VALUES
(3,  6, 1, '08:00:00'),
(3, 19, 2, '08:20:00'),
(3, 20, 3, '08:40:00'),
(3, 13, 4, '09:00:00'),
(3, 16, 5, '09:45:00');

-- Route 4: MP Nagar → Char Imli → Bittan Market → Hoshangabad Road → Misrod
INSERT INTO route_stops (route_id, stop_id, stop_order, arrival_time) VALUES
(4,  5, 1, '09:00:00'),
(4, 11, 2, '09:15:00'),
(4, 12, 3, '09:30:00'),
(4,  8, 4, '09:50:00'),
(4,  9, 5, '10:15:00');

-- Route 5: Karond → Hamidia Road → New Market → Roshanpura → Hoshangabad Road
INSERT INTO route_stops (route_id, stop_id, stop_order, arrival_time) VALUES
(5, 10, 1, '10:00:00'),
(5,  2, 2, '10:20:00'),
(5,  3, 3, '10:40:00'),
(5,  4, 4, '11:00:00'),
(5,  8, 5, '11:20:00');

-- ─────────────────────────────────────────
-- STEP 7: SEED DATA — BUS LOCATIONS
-- ─────────────────────────────────────────

INSERT INTO bus_location (bus_id, current_stop, latitude, longitude) VALUES
(1,  'Hamidia Road',             23.2599, 77.4126),
(2,  'Bairagarh Chouraha',       23.2832, 77.3400),
(3,  'MP Nagar Zone 1',          23.2273, 77.4343),
(4,  'Piplani',                  23.2180, 77.4750),
(5,  'Bhopal Junction',          23.2687, 77.4070),
(6,  'Lalghati',                 23.2750, 77.3900),
(7,  'Char Imli',                23.2445, 77.4295),
(8,  'Bittan Market',            23.2200, 77.4400),
(9,  'Karond Chouraha',          23.3050, 77.4050),
(10, 'Roshanpura Chouraha',      23.2550, 77.4020);

-- ─────────────────────────────────────────
-- STEP 8: VERIFY
-- ─────────────────────────────────────────

SELECT 'routes'      AS tbl, COUNT(*) AS total FROM routes
UNION ALL
SELECT 'stops',       COUNT(*) FROM stops
UNION ALL
SELECT 'buses',       COUNT(*) FROM buses
UNION ALL
SELECT 'route_stops', COUNT(*) FROM route_stops
UNION ALL
SELECT 'bus_location',COUNT(*) FROM bus_location;
