package com.endava.spring.controller;

import com.endava.spring.model.Tweet;
import com.endava.spring.service.TweetService;
import com.endava.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TweetController {

    @Autowired
    private TweetService tweetService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/main")
    public String redirectMain(){
        return "redirect:/main/1";
    }

    @RequestMapping(value = "/main/{page}", method = RequestMethod.GET)
    public String addTweet(@PathVariable("page") int page, ModelMap modelMap){

        int current = page;
        int begin = Math.max(1, current - 2);
        int end = Math.min(begin + 5, tweetService.countPage());

        modelMap.addAttribute("deploymentLog", tweetService.countPage());
        modelMap.addAttribute("beginIndex", begin);
        modelMap.addAttribute("endIndex", end);
        modelMap.addAttribute("currentIndex", current);

        modelMap.addAttribute("tweet", new Tweet());
        modelMap.addAttribute("listTweets", tweetService.listPaginatedTweets(page));
        modelMap.addAttribute("user", userService.findByUserName(getPrincipal()));

        return "main";
    }

    @RequestMapping(value = "/main/{page}", method = RequestMethod.POST)
    public String executeAddTweet(@PathVariable("page") Integer page, @ModelAttribute("tweet") Tweet tweet, ModelMap modelMap){
        tweetService.saveTweet(tweet, userService.findByUserName(getPrincipal()));
        return "redirect:/main";
    }

    @RequestMapping(value = "/editTweet/{id}")
    public String editTweetMessage(@PathVariable("id")int id, ModelMap modelMap){
        modelMap.addAttribute("editTweet", tweetService.getTweetById(id));
        return "editTweet";
    }

    @RequestMapping(value = "/editTweet/{id}", method = RequestMethod.POST)
    public String executeEditTweetMessage(@PathVariable("id") int id, @ModelAttribute("editTweet") Tweet tweet, ModelMap modelMap){
        tweetService.updateTweet(tweet, tweetService.getTweetById(id).getUser());
        return "redirect:/main/1";
    }

    @RequestMapping(value = "/deleteTweet/{id}")
    public String deleteTweet(@PathVariable("id")int id){
        tweetService.removeTweet(id);
        return "redirect:/main/1";
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
