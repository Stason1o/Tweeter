package com.endava.spring.controller;

import com.endava.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by sbogdanschi on 8/05/2017.
 */
@Controller
public class PageController {

    private static int ROLE_MODERATOR = 3;
    private static int ROLE_ADMIN = 1;
    private static int ROLE_USER = 2;

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String displayWelcomePage(ModelMap modelMap) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            modelMap.addAttribute("username", authentication.getName());
        }
        return "welcome";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String displayAdminPage(ModelMap modelMap) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        if (!(authentication instanceof AnonymousAuthenticationToken)) {
//
//
//        }
        modelMap.addAttribute("username", authentication.getName());
        modelMap.addAttribute("listUsers", userService.listUsers());
        return "admin";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.POST)
    public String editUserDetails(@RequestParam(value = "userToDelete", required = false) Integer userIdToDelete,
                                  @RequestParam(value = "userBanUnban", required = false) Integer userToBanOrUnban,
                                  @RequestParam(value = "adminRole", required = false) Integer userIdRoleAdmin,
                                  @RequestParam(value = "moderatorRole", required = false) Integer userIdRoleModerator,
                                  @RequestParam(value = "userRole", required = false) Integer userIdRoleUser) {
        if (userIdToDelete != null) {
            userService.removeUser(userIdToDelete);
        }

        if (userToBanOrUnban != null) {
            userService.updateUserState(userToBanOrUnban);
        }

        if (userIdRoleModerator != null) {
            userService.updateUserRole(userIdRoleModerator, ROLE_MODERATOR);
        }

        if(userIdRoleAdmin != null){
            userService.updateUserRole(userIdRoleAdmin, ROLE_ADMIN);
        }

        if(userIdRoleUser != null){
            userService.updateUserRole(userIdRoleUser, ROLE_USER);
        }
        return "redirect:/admin";
    }

    @RequestMapping(value = "/moderator", method = RequestMethod.GET)
    public String displayModeratorPage(ModelMap modelMap) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            modelMap.addAttribute("username", authentication.getName());
        }
        return "moderator";
    }
}
