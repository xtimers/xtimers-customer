package com.xtimers.customer.server.controller;

import com.xtimers.customer.api.UserApi;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootController  implements UserApi {
    @RequestMapping("/")
    public String root() {
        return "Xtimers Customer";
    }
}
