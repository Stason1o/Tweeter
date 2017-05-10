package com.endava.spring.service.impl;

import com.endava.spring.dao.UserDao;
import com.endava.spring.model.User;
import com.endava.spring.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Override
    public List<User> listUsers() {
        return userDao.listUsers();
    }

    @Override
    public User findByUserName(String username) {
        return userDao.findByUserName(username);
    }

    @Override
    public void saveUser(User user) {
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
        System.out.println("BEFORE UPDATE USER");
        System.out.println(user.getId() + " " + unfollowedUser.getId() + " " + unfollowedUser.getUsername() + "--------------------" );
        for (User user12 : user.getFollowedUsers()) {
            System.out.println(user12.getId());
        }
        userDao.updateUser(user);
        System.out.println("AFTER UPDATE USER");
    }

    @Override
    public List<User> filterFollowedUsers(List<User> listOfAllUsers, User currentUser) {
        List<User> filteredUsers = listOfAllUsers;
        int position = 0;

        for(int i = 0; i < filteredUsers.size(); i++){
            if(filteredUsers.get(i).getId() == currentUser.getId()){
                position = i;
            }
            for (User followedUser : currentUser.getFollowedUsers()) {
                if (filteredUsers.get(i).getId() == followedUser.getId()) {
                    filteredUsers.get(i).setFollowed(true);
                    break;
                }
            }
        }

        filteredUsers.remove(position);
        return filteredUsers;
    }
}
