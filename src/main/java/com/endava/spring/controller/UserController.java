package com.endava.spring.controller;

import com.endava.spring.model.User;
import com.endava.spring.service.SecurityService;
import com.endava.spring.service.UserService;
import com.endava.spring.validator.RegistrationInputValidator;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.List;

@Controller
public class UserController {

    private final static Logger logger = Logger.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private RegistrationInputValidator registrationInputValidator;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String displayLoginPage(ModelMap modelMap) {
        logger.debug("Request of /login page GET");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof AnonymousAuthenticationToken)){
            logger.info("User is logged in. Redirecting to user profile page.");
            return "redirect:/main/1";
        }
        User user = new User();
        modelMap.addAttribute("user", user);
        logger.debug("Opening login page");
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String executeLogin(@ModelAttribute("user") User user) {
        logger.debug("Request of /login page POST");
        return "successPage";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String executeLogout(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("Request of /logout page GET");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        logger.debug("Redirect /login page");
        return "redirect:/login";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String displayLoggedUserProfilePage(ModelMap modelMap) {
        logger.debug("Request of /profile GET");
        modelMap.addAttribute("loggedUser", getPrincipal());
        modelMap.addAttribute("user", userService.findByUsernameInitialized(getPrincipal()));
        logger.debug("Opening profile page");
        return "profile";
    }


    @RequestMapping(value = "/edit/{id}")
    public String editUserDetails(@PathVariable("id") int id, ModelMap modelMap) {
        logger.debug("Request of /edit/"+id + " page ");
        modelMap.addAttribute("loggedUser", getPrincipal());
        modelMap.addAttribute("user", userService.findByIdInitialized(id));

        logger.debug("Opening profile_edit page");
        return "profile_edit";

    }

    @RequestMapping(value = "/delete/{id}")
    public String deleteUser(@PathVariable("id") int id, HttpServletRequest request, HttpServletResponse response) {
        logger.debug("Request of /delete/"+id + " page");
        userService.removeUser(id);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        logger.debug("Redirecting /login page");
        return "redirect:/login";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    public String saveUser(@ModelAttribute("user") User user, BindingResult result, Errors errors, ModelMap modelMap) {
        logger.debug("Request of /profile page POST");
        registrationInputValidator.validate(user, errors);
        if (result.hasErrors()) {
            return "profile";
        }

        userService.updateUser(user);
        securityService.autoLogin(user.getUsername(), user.getPassword());
        logger.debug("Redirecting /profile page");
        return "redirect:/profile";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String displayRegistrationPage(ModelMap modelMap) {
        logger.debug("Request /registration page GET");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!(authentication instanceof AnonymousAuthenticationToken)){
            logger.info("User is logged in. Redirecting to user profile page.");
            return "redirect:/profile";
        }
        modelMap.addAttribute("user", new User());
        logger.debug("Opening registration page");
        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String executeRegistration(@ModelAttribute("user") @Valid User user, BindingResult result, Model model) {
        logger.debug("Request /registration page POST");
        registrationInputValidator.validate(user, result);
        if (result.hasErrors()) {
            return "registration";
        }
        userService.saveUser(user);

        logger.debug("Redirect /login page");
        securityService.autoLogin(user.getUsername(), user.getPassword());
        //logger.debug("Redirect /welcome page");
        return "redirect:/login";
    }

    @RequestMapping(value = "/followFriends", method = RequestMethod.GET)
    public String displayFollowPage(Model modelMap) {
        logger.debug("Request /followFriends page GET");
        User loggedUser = userService.findByUsernameInitialized(getPrincipal());
        List<User> listFollowedUsers = userService.listFollowedUsers(loggedUser.getId());
        List<User> listUnfollowedUsers = userService.listUnfollowedUsers(loggedUser.getId());

        if(listFollowedUsers != null){
            modelMap.addAttribute("listFollowedUsers", listFollowedUsers);
        } else {
            modelMap.addAttribute("emptyList", "You don't have any followed users");
        }
        modelMap.addAttribute("searchUser", new User());

        modelMap.addAttribute("listUnfollowedUsers", listUnfollowedUsers);
        logger.debug("Opening follow page");
        return "follow";
    }

    @RequestMapping(value = "/globalSearch", method = RequestMethod.GET)
    public String displaySearchPage(ModelMap modelMap) {
        logger.debug("Request /globalSearch page GET" );
        modelMap.addAttribute("user", new User());
        logger.debug("Opening searchPage page");
        return "searchPage";
    }

    @RequestMapping(value = "/globalSearch", method = RequestMethod.POST)
    public String displaySearchResult(@ModelAttribute("user")User user, ModelMap modelMap){
        logger.debug("Request /globalSearch POST");
        List<User> listUsers;

        if(user != null) {
            listUsers = userService.searchByUsername(user.getUsername());
            modelMap.addAttribute("user", new User());
            modelMap.addAttribute("listUsers", listUsers);
            modelMap.addAttribute("loggedUser", userService.findByUsernameInitialized(getPrincipal()));
        }
        logger.debug("Opening searchResult page");
        return "searchResult";
    }

    @RequestMapping(value = "/followFriends", method = RequestMethod.POST)
    public String followFriend(@RequestParam(value = "followedFriend", required = false) Integer followedUserId,
                               @RequestParam(value = "unfollowedFriend", required = false) Integer unfollowedUserId) {
        logger.debug("Request /followfriends page POST");
        User loggedUser = userService.findByUsernameInitialized(getPrincipal());

        if(followedUserId != null) {
            System.out.println("IN FOLLOW IF");
            userService.followUser(loggedUser, userService.findByIdInitialized(followedUserId));
        } else if(unfollowedUserId != null){
            System.out.println("IN FOLLOW ELSE IF");
            userService.unfollowUser(loggedUser, userService.findByIdInitialized(unfollowedUserId));
        }

        logger.debug("Redirecting to /followFriends page");
        return "redirect:/followFriends";
    }

    @RequestMapping(value = "/userProfile/{username}")
        public String displayUserProfilePage(@PathVariable( value = "username", required = false) String username, ModelMap modelMap) {
        logger.debug("Request /userProfile/"+username+" page POST");
        if(getPrincipal().equals(username)){
            return "redirect:/profile";
        }
        modelMap.addAttribute("listFollowedUsers", userService.findByUsernameInitialized(getPrincipal()).getFollowedUsers());
        if(username != null) {
            modelMap.addAttribute("user", userService.findByUsernameInitialized(username));
        }
        logger.debug("Opening userProfile page");
        return "userProfile";
    }

    @RequestMapping(value = "/userProfile", method = RequestMethod.POST)
    public String manageUser(@RequestParam(value = "userBanUnban", required = false) Integer userToBanOrUnban,
                             @RequestParam(value = "userToDelete", required = false) Integer userIdToDelete,
                             @RequestParam(value = "unfollowedFriend", required = false) Integer userIdToUnfollow,
                             @RequestParam(value = "followedFriend", required = false) Integer userIdToFollow,
                             RedirectAttributes redirectAttrs){
        logger.debug("Request /userProfile page POST");
        User loggedUser = userService.findByUsernameInitialized(getPrincipal());
        if(userIdToFollow != null){
            User user = userService.findByIdInitialized(userIdToFollow);
            userService.followUser(loggedUser, user);
            redirectAttrs.addAttribute("username", user.getUsername());
            logger.debug("Redirecting to /userProfile/"+user.getUsername()+" page");
            return "redirect:/userProfile/{username}";
        }

        if(userIdToUnfollow != null){
            User user = userService.findByIdInitialized(userIdToUnfollow);
            userService.unfollowUser(loggedUser, user);
            redirectAttrs.addAttribute("username", user.getUsername());
            logger.debug("Redirecting to /userProfile/"+user.getUsername()+" page");
            return "redirect:/userProfile/{username}";
        }

        if(userToBanOrUnban != null){
            userService.updateUserState(userToBanOrUnban);
            User user = userService.findById(userToBanOrUnban);
            redirectAttrs.addAttribute("username", user.getUsername());
            logger.debug("Redirecting to /userProfile/"+user.getUsername()+" page");
            return "redirect:/userProfile/{username}";
        }

        if(userIdToDelete != null){
            userService.removeUser(userIdToDelete);
            logger.debug("Opening profile page");
            return "profile";
        }

        return "redirect:/profile";
    }

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
