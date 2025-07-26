package com.example.countryservice.service;

import com.example.countryservice.entity.Country;
import com.example.countryservice.repository.CountryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CountryService {

    @Autowired
    private CountryRepository countryRepository;

    public Country getCountryByCode(String code) {
        return countryRepository.findByCode(code);
    }
}
