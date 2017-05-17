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

        modelMap.addAttribute("deploymentLog", tweetService.countPage());
        modelMap.addAttribute("beginIndex", Math.max(1, page - 2));
        modelMap.addAttribute("endIndex", Math.min(Math.max(1, page - 2) + 5, tweetService.countPage()));
        modelMap.addAttribute("currentIndex", page);

        modelMap.addAttribute("tweet", new Tweet());
        modelMap.addAttribute("listTweets", tweetService.listPaginatedTweetsById(0, page));
        modelMap.addAttribute("user", userService.findByUsernameInitialized(getPrincipal()));
//        modelMap.addAttribute("likeList", tweetService.getLikeList(0, page));


        return "main";
    }

    @RequestMapping(value = "/main/{page}", method = RequestMethod.POST)
    public String executeAddTweet(@PathVariable("page") Integer page, @ModelAttribute("tweet") Tweet tweet, ModelMap modelMap){
        tweetService.saveTweet(tweet, userService.findByUsernameInitialized(getPrincipal()));
        return "redirect:/main";
    }

    @RequestMapping(value = "/editTweet/{idTw}")
    public String editTweetMessage(@PathVariable("idTw")int id, ModelMap modelMap){
        modelMap.addAttribute("editTweet", tweetService.getTweetById(id));
        modelMap.addAttribute("user", userService.findByUsernameInitialized(getPrincipal()));
        modelMap.addAttribute("idtw", id);
        return "editTweet";
    }

    @RequestMapping(value = "/editTweet/{idTw}", method = RequestMethod.POST)
    public String executeEditTweetMessage(@PathVariable("idTw") int id,
                                          @ModelAttribute("editTweet") Tweet tweet, ModelMap modelMap){
        tweetService.updateTweet(tweet, tweetService.getTweetById(id).getUser());
        return "redirect:/tweetPage/{idTw}";
    }

    @RequestMapping(value = "/deleteTweet/{id}")
    public String deleteTweet(@PathVariable("id")int id){
        tweetService.removeTweet(id);
        return "redirect:/main/1";
    }

    @RequestMapping(value = "/reTweet/{id}")
    public String reTweet(@PathVariable("id")int id, ModelMap modelMap){
        tweetService.reTweet(new Tweet(), userService.findByUsernameInitialized(getPrincipal()), id);
        return "redirect:/main/1";
    }

    @RequestMapping(value = "/tweetPage/{idT}/{page}", method = RequestMethod.GET)
    public String commitTweet(@PathVariable("page") Integer page, @PathVariable("idT")int id, ModelMap modelMap){
        modelMap.addAttribute("commit", new Tweet());
        modelMap.addAttribute("tweet", tweetService.getTweetById(id));
        modelMap.addAttribute("commitTweets", tweetService.getTweetComment(id));
        modelMap.addAttribute("page", page);
        return "tweetPage";
    }

    @RequestMapping(value = "/tweetPage/{idT}/{page}", method = RequestMethod.POST)
    public String executeCommitTweetMessage(@PathVariable("page") Integer page, @PathVariable("idT") int id,
                                            @ModelAttribute("commit") Tweet tweet, ModelMap modelMap){
        tweetService.commit(tweet, userService.findByUsernameInitialized(getPrincipal()), id);
        return "redirect:/tweetPage/{idT}/{page}";
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
