package com.endava.spring.controller;

import com.endava.spring.model.User;
import com.endava.spring.service.SecurityService;
import com.endava.spring.service.UserService;
import com.endava.spring.validator.RegistrationInputValidator;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private RegistrationInputValidator registrationInputValidator;

//    @InitBinder
//    public void initWebBinder(WebDataBinder webDataBinder) {
//        webDataBinder.setValidator(userInputValidator);
//    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String displayLoginPage(ModelMap modelMap) {
        User user = new User();
//        modelMap.addAttribute("users", userService.listUsers());
        modelMap.addAttribute("user", user);
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String executeLogin(@ModelAttribute("user") User user) {
        return "successPage";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String executeLogout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String displayLoggedUserProfilePage(ModelMap modelMap) {
        System.out.println("/profile GET");
        modelMap.addAttribute("loggedUser", getPrincipal());
        modelMap.addAttribute("user", userService.findByUsernameInitialized(getPrincipal()));
        return "profile";
    }

    @RequestMapping(value = "/edit/{id}")
    public String editUserDetails(@PathVariable("id") int id, ModelMap modelMap) {
        System.out.println("edit");
        modelMap.addAttribute("loggedUser", getPrincipal());
        modelMap.addAttribute("user", userService.findByIdInitialized(id));
        return "profile";
    }

    @RequestMapping(value = "/delete/{id}")
    public String deleteUser(@PathVariable("id") int id) {
        userService.removeUser(id);
        return "redirect:/login";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    public String saveUser(@ModelAttribute("user") User user, BindingResult result, Errors errors, ModelMap modelMap) {
        System.out.println("/profile POST");
        registrationInputValidator.validate(user, errors);
        if (result.hasErrors()) {
            return "profile";
        }

        System.out.println("in saveUser : " + user);
        userService.updateUser(user);
        securityService.autoLogin(user.getUsername(), user.getPassword());
        return "redirect:/profile";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String displayRegistrationPage(ModelMap modelMap) {
        modelMap.addAttribute("user", new User());
        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String executeRegistration(@ModelAttribute("user") @Valid User user, BindingResult result, Model model) {
        registrationInputValidator.validate(user, result);
        if (result.hasErrors()) {
            return "registration";
        }
        userService.saveUser(user);
        securityService.autoLogin(user.getUsername(), user.getConfirmPassword());
        return "redirect:/welcome";
    }

    @RequestMapping(value = "/followFriends", method = RequestMethod.GET)
    public String displayFollowPage(Model modelMap) {
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
        return "follow";
    }

    @RequestMapping(value = "/globalSearch", method = RequestMethod.GET)
    public String displaySearchPage(ModelMap modelMap) {
        modelMap.addAttribute("user", new User());
        return "searchPage";
    }

    @RequestMapping(value = "/globalSearch", method = RequestMethod.POST)
    public String displaySearchResult(@ModelAttribute("user")User user, ModelMap modelMap){
        List<User> listUsers;
        if(user != null) {
            listUsers = userService.searchByUsername(user.getUsername());
            modelMap.addAttribute("user", new User());
            modelMap.addAttribute("listUsers", listUsers);
            modelMap.addAttribute("loggedUser", userService.findByUsernameInitialized(getPrincipal()));
        }

        return "searchResult";
    }

    @RequestMapping(value = "/followFriends", method = RequestMethod.POST)
    public String followFriend(@RequestParam(value = "followedFriend", required = false) Integer followedUserId,
                               @RequestParam(value = "unfollowedFriend", required = false) Integer unfollowedUserId) {
        System.out.println("IN FOLLOW FRIEND");
        User loggedUser = userService.findByUsernameInitialized(getPrincipal());

        if(followedUserId != null) {
            System.out.println("IN FOLLOW IF");
            userService.followUser(loggedUser, userService.findByIdInitialized(followedUserId));
        } else if(unfollowedUserId != null){
            System.out.println("IN FOLLOW ELSE IF");
            userService.unfollowUser(loggedUser, userService.findByIdInitialized(unfollowedUserId));
        }

        return "redirect:/followFriends";
    }

    @RequestMapping(value = "/userProfile/{username}")
        public String displayUserProfilePage(@PathVariable( value = "username", required = false) String username, ModelMap modelMap) {
        if(getPrincipal().equals(username)){
            return "redirect:/profile";
        }
        modelMap.addAttribute("listFollowedUsers", userService.findByUsernameInitialized(getPrincipal()).getFollowedUsers());
        if(username != null) {
            modelMap.addAttribute("user", userService.findByUsernameInitialized(username));
        }
        return "userProfile";
    }

    @RequestMapping(value = "/userProfile", method = RequestMethod.POST)
    public String manageUser(@RequestParam(value = "userBanUnban", required = false) Integer userToBanOrUnban,
                             @RequestParam(value = "userToDelete", required = false) Integer userIdToDelete,
                             @RequestParam(value = "unfollowedFriend", required = false) Integer userIdToUnfollow,
                             @RequestParam(value = "followedFriend", required = false) Integer userIdToFollow,
                             RedirectAttributes redirectAttrs){
        User loggedUser = userService.findByUsernameInitialized(getPrincipal());
        if(userIdToFollow != null){
            User user = userService.findByIdInitialized(userIdToFollow);
            userService.followUser(loggedUser, user);
            redirectAttrs.addAttribute("username", user.getUsername());
            return "redirect:/userProfile/{username}";
        }

        if(userIdToUnfollow != null){
            User user = userService.findByIdInitialized(userIdToUnfollow);
            userService.unfollowUser(loggedUser, user);
            redirectAttrs.addAttribute("username", user.getUsername());
            return "redirect:/userProfile/{username}";
        }

        if(userToBanOrUnban != null){
            userService.updateUserState(userToBanOrUnban);
            redirectAttrs.addAttribute("username", userService.findById(userToBanOrUnban).getUsername());
            return "redirect:/userProfile/{username}";
        }

        if(userIdToDelete != null){
            userService.removeUser(userIdToDelete);
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
