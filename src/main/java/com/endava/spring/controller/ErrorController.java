package com.endava.spring.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ErrorController {

    private final static Logger logger = Logger.getLogger(ErrorController.class);

    @RequestMapping(value = "/link403", method = RequestMethod.GET)
    public String httpError403(){
        logger.debug("Request /link403 ACCESS DENIED PAGE");
        return "HTTP403";
    }

    @RequestMapping(value = "/link404", method = RequestMethod.GET)
    public String httpError404(){
        logger.debug("Request /link404 PAGE NOT FOUND");
        return "HTTP404";
    }
}

