package com.example.restcountrywebservice;

public class countrywebservice {
    private String name;
    private String capital;
    private long population;

    public countrywebservice() {}

    public countrywebservice(String name, String capital, long population) {
        this.name = name;
        this.capital = capital;
        this.population = population;
    }

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCapital() { return capital; }
    public void setCapital(String capital) { this.capital = capital; }

    public long getPopulation() { return population; }
    public void setPopulation(long population) { this.population = population; }
}

