package com.endava.spring.controller;

import com.endava.spring.model.Tweet;
import com.endava.spring.service.TweetService;
import com.endava.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Date;

@Controller
public class TweetController {

    @Autowired
    private TweetService tweetService;

    @Autowired
    private UserService userService;

    /*@RequestMapping(value = "/main")
    public String viewTweets(ModelMap modelMap){
        modelMap.addAttribute("listTweets", tweetService.listTweets());
        return "main";
    }*/

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String addTweet(ModelMap modelMap){
        modelMap.addAttribute("tweet", new Tweet());
        modelMap.addAttribute("listTweets", tweetService.listTweets());

        return "main";
    }

    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public String executeAddTweet(@ModelAttribute("tweet") Tweet tweet, ModelMap modelMap){
        tweetService.saveTweet(tweet, userService.findByUserName(getPrincipal()));

        return "redirect:/main";
    }

    // Need to do static
    private String getPrincipal() {
        String userName;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails) {
            userName = ((UserDetails) principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }
}
