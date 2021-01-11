package com.xtimers.customer.server.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootController {
    @RequestMapping("/")
    public String root() {
        return "Xtimers Customer";
    }
}
