package com.endava.spring.controller;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by sbogdanschi on 8/05/2017.
 */@Controller
public class PageController {

//    @RequestMapping(value = "/", method = RequestMethod.GET)
//    public String helloWorld(ModelMap modelMap){
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        if (!(authentication instanceof AnonymousAuthenticationToken)) {
//            modelMap.addAttribute("username", authentication.getName());
//        }
//
//        //int num = userService
//        //User user = tweetService.listTweets().get(0).getUser();
//        //modelMap.addAttribute("listAll", tweetService.listTweets());
//        //modelMap.addAttribute("one", tweetService.listTweets().get(0).getUser());
//        return "index";
//    }

    @RequestMapping(value = {"/","/welcome"}, method = RequestMethod.GET)
    public String displayWelcomePage(ModelMap modelMap){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            modelMap.addAttribute("username", authentication.getName());
        }
        return "welcome";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String displayAdminPage(ModelMap modelMap){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            modelMap.addAttribute("username", authentication.getName());
        }
        return "admin";
    }

    @RequestMapping(value = "/moderator", method = RequestMethod.GET)
    public String displayModeratorPage(ModelMap modelMap){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            modelMap.addAttribute("username", authentication.getName());
        }
        return "moderator";
    }
}
