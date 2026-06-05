package com.smarttransit.model;

public class Route {
    private int    routeId;
    private String routeName;
    private String startPoint;
    private String endPoint;
    private double distanceKm;
    private double fare;

    public Route() {}

    public Route(int routeId, String routeName, String startPoint,
                 String endPoint, double distanceKm, double fare) {
        this.routeId    = routeId;
        this.routeName  = routeName;
        this.startPoint = startPoint;
        this.endPoint   = endPoint;
        this.distanceKm = distanceKm;
        this.fare       = fare;
    }

    public int    getRouteId()    { return routeId; }
    public String getRouteName()  { return routeName; }
    public String getStartPoint() { return startPoint; }
    public String getEndPoint()   { return endPoint; }
    public double getDistanceKm() { return distanceKm; }
    public double getFare()       { return fare; }

    public void setRouteId(int routeId)          { this.routeId = routeId; }
    public void setRouteName(String routeName)   { this.routeName = routeName; }
    public void setStartPoint(String startPoint) { this.startPoint = startPoint; }
    public void setEndPoint(String endPoint)     { this.endPoint = endPoint; }
    public void setDistanceKm(double distanceKm) { this.distanceKm = distanceKm; }
    public void setFare(double fare)             { this.fare = fare; }
}