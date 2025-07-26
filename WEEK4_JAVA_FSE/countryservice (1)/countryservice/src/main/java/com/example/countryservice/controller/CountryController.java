package com.example.countryservice.controller;

import com.example.countryservice.entity.Country;
import com.example.countryservice.service.CountryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/countries")
public class CountryController {

    @Autowired
    private CountryService countryService;

    @GetMapping("/{code}")
    public Country getCountry(@PathVariable String code) {
        return countryService.getCountryByCode(code);
    }
}
