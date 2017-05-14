package com.endava.spring.service;

import com.endava.spring.dao.UserDao;
import com.endava.spring.model.Role;
import com.endava.spring.model.User;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by sbogdanschi on 2/05/2017.
 */
@Service("userDetailsService")
@Transactional
public class CustomUserDetailsService implements UserDetailsService {

    private final static Logger logger = Logger.getLogger("connectionsLogger");

    @Autowired
    private UserDao userDao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        logger.log(Level.INFO,"Loading user by username");
        User user = userDao.findByUserName(username);
        List<GrantedAuthority> authorities =
                buildUserAuthority(user.getRoles());
        logger.log(Level.INFO, "Preparing user for authentication");
        return buildUserForAuthentication(user, authorities);
    }

    private UserDetails buildUserForAuthentication(User user,
                                                   List<GrantedAuthority> authorities) {
        logger.log(Level.INFO, "Building user for authentication");
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
                user.isEnabled(), true, true, true, authorities);
    }

    private List<GrantedAuthority> buildUserAuthority(Set<Role> userRoles) {
        logger.log(Level.INFO, "Setting authorities to user");
        Set<GrantedAuthority> setAuths = new HashSet<>();

        // Build user's authorities
        for (Role userRole : userRoles) {
            setAuths.add(new SimpleGrantedAuthority(userRole.getRole()));
            logger.log(Level.INFO, "Authority: " + userRole.getRole());
        }
        logger.log(Level.INFO, "Returning list of authorities");
        return new ArrayList<>(setAuths);
    }
}
