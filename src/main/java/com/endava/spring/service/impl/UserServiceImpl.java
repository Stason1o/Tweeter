package com.endava.spring.service.impl;

import com.endava.spring.dao.UserDao;
import com.endava.spring.model.Role;
import com.endava.spring.model.User;
import com.endava.spring.service.UserService;
import org.apache.log4j.Logger;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

    private final static Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Autowired
    private UserDao userDao;

    @Autowired
    private PasswordEncoder bCryptPasswordEncoder;

    @Override
    public List<User> listInitializedUsers() {
        List<User> list = userDao.listUsers();
        for (User user : list) {
            if (user != null) {
                Hibernate.initialize(user.getFollowedUsers());
                Hibernate.initialize(user.getTweets());
            }
        }
        return userDao.listUsers();
    }

    @Override
    public List<User> listUsers() {
        return userDao.listUsers();
    }

    @Override
    public List<User> listUnfollowedUsers(int id) {
        return userDao.listUnfollowedUsers(id);
    }

    @Override
    public User findByUsernameInitialized(String username) {
        User user = userDao.findByUserName(username);
        if (user != null) {
            Hibernate.initialize(user.getTweets());
            Hibernate.initialize(user.getFollowedUsers());
        }
        return user;
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUserName(username);
    }

    @Override
    public void saveUser(User user) {
        String password = user.getPassword();
        user.setPassword(bCryptPasswordEncoder.encode(password));
        user.setConfirmPassword(bCryptPasswordEncoder.encode(password));
        userDao.saveUser(user);
    }

    @Override
    public void followUser(User user, User followedUser) {
        if (!user.getFollowedUsers().contains(followedUser)) {
            user.getFollowedUsers().add(followedUser);
            userDao.updateUser(user);
        }
    }

    @Override
    public User findByEmailInitialized(String email) {
        User user = userDao.findByEmail(email);
        if (user != null) {
            Hibernate.initialize(user.getFollowedUsers());
            Hibernate.initialize(user.getTweets());
        }
        return user;
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void removeUser(int id) {
        userDao.removeUser(id);
    }

    @Override
    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    @Override
    public User findByIdInitialized(int id) {
        User user = userDao.findById(id);
        if (user != null) {
            Hibernate.initialize(user.getTweets());
            Hibernate.initialize(user.getFollowedUsers());
        }
        return user;
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void unfollowUser(User user, User unfollowedUser) {
        System.out.println("IN UNFOLLOW USER METHOD");
        User foundUser = new User();
        for (User target : user.getFollowedUsers()) {
            if (target.getId() == unfollowedUser.getId()) {
                foundUser = target;
            }
        }
        user.getFollowedUsers().remove(foundUser);
        userDao.updateUser(user);
    }

    @Override
    public List<User> listFollowedUsers(int id) {
        return userDao.listFollowedUsers(id);
    }

    public void updateUserRole(int userId, int roleId) {
        User user = userDao.findById(userId);
        Role role = createRole(roleId);

        boolean flag = false;

        if (role != null) {
            for (Role userRole : user.getRoles()) {
                if (role.getRole().equals(userRole.getRole())) {
                    role = userRole;
                    flag = true;
                }
            }
        }

        if (flag) {
            user.getRoles().remove(role);
            userDao.updateUser(user);
        } else {
            user.getRoles().add(role);
            userDao.updateUser(user);
        }
    }

    @Override
    public void updateUserState(int id) {
        User user = userDao.findById(id);
        if (user.isEnabled()) {
            user.setEnabled(false);
        } else {
            user.setEnabled(true);
        }
        userDao.updateUser(user);
    }

    @Override
    public List<User> searchByUsername(String username) {
        return userDao.searchByUsername(username);
    }


//    @Override
//    public List<User> searchByUser(User user) {
//        boolean isUsernameNotNull = contains(user.getUsername());
//        boolean isFirstNameNotNull = contains(user.getFirstName());
//        boolean isLastNameNotNull = contains(user.getLastName());
//
//        return searchByUsernameFirstNameLastName(isUsernameNotNull, isFirstNameNotNull, isLastNameNotNull, user);
//    }

    private static Role createRole(int id) {
        if (id == 1) {
            return new Role(1, "ROLE_ADMIN");
        }
        if (id == 2) {
            return new Role(2, "ROLE_USER");
        }
        if (id == 3) {
            return new Role(3, "ROLE_MODERATOR");
        }
        return null;
    }

//    private static boolean contains(String string) {
//        return string != null;
//    }
//
//    private List<User> searchByUsernameFirstNameLastName(boolean isUsernameNotNull, boolean isFirstNameNotNull, boolean isLastNameNotNull, User user){
//        List<User> list = new ArrayList<>();
//        if (isUsernameNotNull){
//            list.add(searchByUsernameFirstNameOrLastNameOrBoth(isFirstNameNotNull, isLastNameNotNull, user));
//            return list;
//        } else {
//            return searchByFirstNameOrLastNameOrBoth(isFirstNameNotNull, isLastNameNotNull, user);
//        }
//    }
//
//    private List<User> searchByFirstNameOrLastNameOrBoth(boolean isFirstNameNotNull, boolean isLastNameNotNull, User user){
//        List<User> list = new ArrayList<>();
//        if (isFirstNameNotNull && isLastNameNotNull){
//            list.add(userDao.searchByFirstNameLastName(user.getFirstName(), user.getLastName()));
//            return list;
//        } else if(isFirstNameNotNull){
//            list.add(userDao.findByUserName(user.getFirstName()));
//            return list;
//        } else {
//            return userDao.searchByLastName(user.getLastName());
//        }
//    }
//
//    private User searchByUsernameFirstNameOrLastNameOrBoth(boolean isFirstNameNotNull, boolean isLastNameNotNull, User user){
//        if(isFirstNameNotNull && isLastNameNotNull){
//            return userDao.searchByUsernameFirstNameLastName(user.getUsername(), user.getFirstName(), user.getLastName());
//        } else if(isFirstNameNotNull){
//            return userDao.searchByUsernameFirstName(user.getUsername(), user.getFirstName());
//        } else if(isLastNameNotNull){
//            return userDao.searchByUsernameLastName(user.getUsername(), user.getLastName());
//        } else {
//            return userDao.findByUserName(user.getUsername());
//        }
//    }
}
