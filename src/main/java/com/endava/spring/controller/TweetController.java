package com.endava.spring.controller;

import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import com.endava.spring.service.TweetService;
import com.endava.spring.service.UserService;
import com.endava.spring.validator.TweetContentValidator;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class TweetController {

    private final static String PROFILE_PAGE = "profile";
    private final static String USER_PROFILE_PAGE = "userProfile";
    private final static Logger logger = Logger.getLogger(TweetController.class);

    @Autowired
    private TweetService tweetService;

    @Autowired
    private UserService userService;

    @Autowired
    private TweetContentValidator tweetContentValidator;

    @RequestMapping(value = "/main")
    public String redirectMain() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(authentication instanceof AnonymousAuthenticationToken){
            return "redirect:/login";
        }
        return "redirect:/main/1";
    }

    @RequestMapping(value = "/main/{page}", method = RequestMethod.GET)
    public String addTweet(@PathVariable("page") int page, ModelMap modelMap) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(authentication instanceof AnonymousAuthenticationToken){
            return "redirect:/login";
        }

        User loggedUser = userService.findByUsernameInitialized(getPrincipal());

        System.out.println("deploymentLog" + tweetService.countPage(loggedUser.getId(), false) + "--------------------------------------------------------------------------------------------------------------");
        System.out.println("beginIndex" + Math.max(1, page - 2) + "--------------------------------------------------------------------------------------------------------------");
        System.out.println("endIndex" + Math.min(Math.max(1, page - 2) + 5, tweetService.countPage(loggedUser.getId(), false)) + "--------------------------------------------------------------------------------------------------------------");
        System.out.println("currentIndex" + page + "--------------------------------------------------------------------------------------------------------------");


        logger.debug("Request /main/" + page + " page GET");
        modelMap.addAttribute("deploymentLog", tweetService.countPage(loggedUser.getId(), false));
        modelMap.addAttribute("beginIndex", Math.max(1, page - 2));
        modelMap.addAttribute("endIndex", Math.min(Math.max(1, page - 2) + 5, tweetService.countPage(loggedUser.getId(), false)));
        modelMap.addAttribute("currentIndex", page);

        modelMap.addAttribute("tweet", new Tweet());
        modelMap.addAttribute("listTweets", tweetService.listPaginatedTweetsById(loggedUser.getId(), page));
        modelMap.addAttribute("user", loggedUser);

        logger.debug("Opening main page");
        return "main";
    }

    @RequestMapping(value = "/main/{page}", method = RequestMethod.POST)
    public String executeAddTweet(@PathVariable("page") Integer page,
                                  BindingResult result, Errors errors,
                                  @ModelAttribute("tweet") Tweet tweet,
                                  RedirectAttributes redirectAttributes) {
        logger.debug("Request /main POST");
        tweetContentValidator.validate(tweet, errors);
        if(result.hasErrors()){
            redirectAttributes.addAttribute("page", page);
            return "main";
        }
        tweetService.saveTweet(tweet, userService.findByUsernameInitialized(getPrincipal()));
        logger.debug("Redirecting /main");
        return "redirect:/main";
    }

    @RequestMapping(value = "/editTweet/{idTw}")
    public String editTweetMessage(@PathVariable("idTw")int id,
                @RequestParam(value = "page", required = false)int page, ModelMap modelMap) {
        logger.debug("Request /editTweet/" + id + " page");
        modelMap.addAttribute("editTweet", tweetService.getTweetById(id));
        modelMap.addAttribute("user", userService.findByUsernameInitialized(getPrincipal()));
        modelMap.addAttribute("idtw", id);
        modelMap.addAttribute("page", page);
        logger.debug("Opening editTweet page");
        return "editTweet";
    }

    @RequestMapping(value = "/editTweet/{idTw}", method = RequestMethod.POST)
    public String executeEditTweetMessage(@PathVariable("idTw") int id,
                                          @RequestParam(value = "page", required = false)int page,
                                          @ModelAttribute("editTweet") Tweet tweet, RedirectAttributes redirectAttributes) {
        logger.debug("Request /editTweet/" + id + " page POST");
        tweetService.updateTweet(tweet, tweetService.getTweetById(id).getUser());
        redirectAttributes.addAttribute("page", page);
        logger.debug("Redirecting /tweetPage/" + id);
        return "redirect:/tweetPage/{idTw}/{page}";
    }


    @RequestMapping(value = "/deleteTweet/{id}/{page}")
    public String deleteTweet(@PathVariable("id") int id,
                              @PathVariable("page") String page,
                              RedirectAttributes redirectAttributes) {
        logger.debug("Request /deleteTweet/" + id);
        tweetService.removeTweet(id);
        logger.debug("Redirecting /main/1");
//        if( page.equals(PROFILE_PAGE)) {
//
//        } else if (page.equals(USER_PROFILE_PAGE)){
//            return "redirect:/"
//        }
        return "redirect:/profile";
    }

    @RequestMapping(value = "/reTweet/{id}")
    public String reTweet(@PathVariable("id") int id, ModelMap modelMap) {
        logger.debug("Request /reTweet/" + id + " page");
        tweetService.reTweet(new Tweet(), userService.findByUsernameInitialized(getPrincipal()), id);
        logger.debug("Redirecting /main/1");
        return "redirect:/main/1";
    }

    @RequestMapping(value = "/tweetPage/{idT}/{page}", method = RequestMethod.GET)
    public String commitTweet(@PathVariable("page") Integer page, @PathVariable("idT")int id, ModelMap modelMap){
        logger.debug("Request /tweetPage/" + id+"/"+ page + " page");
        modelMap.addAttribute("loggedUser", userService.findByUsername(getPrincipal()));
        modelMap.addAttribute("commit", new Tweet());
        modelMap.addAttribute("tweet", tweetService.getTweetById(id));
        modelMap.addAttribute("commitTweets", tweetService.getTweetComment(id));
        modelMap.addAttribute("page", page);
        logger.debug("Opening tweetPage");
        return "tweetPage";
    }

    @RequestMapping(value = "/tweetPage/{idT}/{page}", method = RequestMethod.POST)
    public String executeCommitTweetMessage(@PathVariable("page") Integer page, @PathVariable("idT") int id,
                                            @ModelAttribute("commit") Tweet tweet, RedirectAttributes redirectAttributes){
        logger.debug("Request /tweetPage/" + id + " page");
        System.out.println(tweet.getContent() + "------------------------------=====================");
        if(!tweet.getContent().equals("")) {
            System.out.println("IN IF ---------------");
            tweetService.commit(tweet, userService.findByUsernameInitialized(getPrincipal()), id);
            redirectAttributes.addAttribute("page", page);
        }
        logger.debug("Redirecting /tweetPage/" + id);
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
