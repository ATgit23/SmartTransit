package com.smarttransit.model;

public class Bus {
    private int    busId;
    private String busNumber;
    private int    capacity;
    private String status;
    private int    routeId;
    private String routeName;
    private String currentStop;

    public Bus() {}

    public Bus(int busId, String busNumber, int capacity, String status, int routeId) {
        this.busId     = busId;
        this.busNumber = busNumber;
        this.capacity  = capacity;
        this.status    = status;
        this.routeId   = routeId;
    }

    public int    getBusId()       { return busId; }
    public String getBusNumber()   { return busNumber; }
    public int    getCapacity()    { return capacity; }
    public String getStatus()      { return status; }
    public int    getRouteId()     { return routeId; }
    public String getRouteName()   { return routeName; }
    public String getCurrentStop() { return currentStop; }

    public void setBusId(int busId)            { this.busId = busId; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }
    public void setCapacity(int capacity)      { this.capacity = capacity; }
    public void setStatus(String status)       { this.status = status; }
    public void setRouteId(int routeId)        { this.routeId = routeId; }
    public void setRouteName(String routeName) { this.routeName = routeName; }
    public void setCurrentStop(String s)       { this.currentStop = s; }
}