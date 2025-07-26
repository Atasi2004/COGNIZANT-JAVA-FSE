package com.example.companydemo;

public class Country {
    private String name;
    private String capital;

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCapital() {
        return capital;
    }

    public void setCapital(String capital) {
        this.capital = capital;
    }

    @Override
    public String toString() {
        return "Country [name=" + name + ", capital=" + capital + "]";
    }
}
