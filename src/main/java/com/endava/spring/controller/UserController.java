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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
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
    public String displayLoginPage(ModelMap modelMap){
        User user = new User();
        modelMap.addAttribute("users", userService.listUsers());
        modelMap.addAttribute("user", user);
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String executeLogin(@ModelAttribute("user") User user){
        return "successPage";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String executeLogout(HttpServletRequest request, HttpServletResponse response){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String displayProfilePage(ModelMap modelMap){
        System.out.println("/profile GET");
        modelMap.addAttribute("loggedUser", getPrincipal());
        modelMap.addAttribute("user", userService.findByUserName(getPrincipal()));
        return "profile";
    }

    @RequestMapping(value = "/edit/{id}")
    public String editUserDetails(@PathVariable("id")int id, ModelMap modelMap){
        System.out.println("edit");
        modelMap.addAttribute("loggedUser", getPrincipal());
        modelMap.addAttribute("user", userService.findById(id));
        return "profile";
    }

    @RequestMapping(value = "/delete/{id}")
    public String deleteUser(@PathVariable("id")int id){
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
    public String displayRegistrationPage(ModelMap modelMap){
        modelMap.addAttribute("user", new User());
        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String executeRegistration(@ModelAttribute("user") @Valid User user, BindingResult result, Model model){
        registrationInputValidator.validate(user, result);
        if(result.hasErrors()){
            return "registration";
        }
        userService.saveUser(user);
        securityService.autoLogin(user.getUsername(), user.getConfirmPassword());
        return "redirect:/welcome";
    }

    @RequestMapping(value = "/followFriends",  method = RequestMethod.GET)
    public String displayFollowPage(ModelMap modelMap){
        modelMap.addAttribute("listUsers", userService.listUsers());
        return "follow";
    }

    @RequestMapping(value = "/followFriends", method = RequestMethod.POST)
    public String followFriend(@ModelAttribute("user") User user, ModelMap modelMap){
        return "redirect:/follow";
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