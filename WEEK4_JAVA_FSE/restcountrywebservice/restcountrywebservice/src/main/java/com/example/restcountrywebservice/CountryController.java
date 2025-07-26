package com.example.restcountrywebservice;

//import com.example.restcountrywebservice.countrywebservice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CountryController {

    @GetMapping("/country")
    public countrywebservice getCountry() {
        return new countrywebservice("India", "New Delhi", 1400000000);
    }
}
