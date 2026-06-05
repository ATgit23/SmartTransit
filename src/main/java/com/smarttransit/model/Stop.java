package com.smarttransit.model;

public class Stop {
    private int    stopId;
    private String stopName;
    private String location;

    public Stop() {}

    public Stop(int stopId, String stopName, String location) {
        this.stopId   = stopId;
        this.stopName = stopName;
        this.location = location;
    }

    public int    getStopId()   { return stopId; }
    public String getStopName() { return stopName; }
    public String getLocation() { return location; }

    public void setStopId(int stopId)         { this.stopId = stopId; }
    public void setStopName(String stopName)  { this.stopName = stopName; }
    public void setLocation(String location)  { this.location = location; }
}