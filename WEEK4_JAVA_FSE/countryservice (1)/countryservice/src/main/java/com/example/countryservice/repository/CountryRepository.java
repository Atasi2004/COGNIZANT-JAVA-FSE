package com.example.countryservice.repository;

import com.example.countryservice.entity.Country;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CountryRepository extends JpaRepository<Country, String> {
    Country findByCode(String code);
}
