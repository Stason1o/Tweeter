package com.endava.spring.service.impl;

import com.endava.spring.dao.UserDao;
import com.endava.spring.model.User;
import com.endava.spring.service.UserService;
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

    @Autowired
    private UserDao userDao;

    @Override
    public List<User> listUsers() {
        return userDao.listUsers();
    }

    @Override
    public User findByUserName(String username){
        return userDao.findByUserName(username);
    }

    @Override
    public void saveUser(User user) {

        userDao.saveUser(user);
    }

    @Override
    public void followUser(User user, User followedUser) {
        user.getFollowedUsers().add(followedUser);
        userDao.followUser(user);
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
//        if(user.getPassword().length() < 1)
//            user.setPassword(userDao.findById(user.getId()).getPassword());
        System.out.println("in update user :  " + user);
        userDao.updateUser(user);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void unfollowUser(User user, User unfollowedUser) {
        User foundUser = new User();
        for (User target: user.getFollowedUsers()) {
            if(target.getId() == unfollowedUser.getId()){
                foundUser = target;
            }
        }
        user.getFollowedUsers().remove(foundUser);
        userDao.updateUser(user);
    }

}
