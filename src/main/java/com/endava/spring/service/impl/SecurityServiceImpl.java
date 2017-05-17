package com.endava.spring.service.impl;

import com.endava.spring.service.SecurityService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by sbogdanschi on 3/05/2017.
 */
@Service
@Transactional
public class SecurityServiceImpl implements SecurityService {

    private final static Logger logger = Logger.getLogger(SecurityServiceImpl.class);

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService userDetailsService;

    @Override
    public String findLoggedInUser() {
        logger.info("Searching for logged user");
        Object userDetails = SecurityContextHolder.getContext().getAuthentication().getDetails();
        if(userDetails instanceof UserDetails) {
            String username = ((UserDetails) userDetails).getUsername();
            logger.info("Found user: " + username);
            return username;
        }
        return null;
    }

    @Override
    public void autoLogin(String username, String password) {
        logger.info("Auto loggin user: " + username);
        UserDetails userDetails = userDetailsService.loadUserByUsername(username);
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(userDetails, password, userDetails.getAuthorities());
        logger.info("password: = " + password + " userDetails: = "  + userDetails.getPassword());
        authenticationManager.authenticate(authenticationToken);
        if(authenticationToken.isAuthenticated()) {
            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            logger.info("User is successfully logged in");
        } else {
            logger.info("problems in authentication");
        }
    }
}
