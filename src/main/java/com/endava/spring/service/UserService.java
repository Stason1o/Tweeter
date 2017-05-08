package com.endava.spring.service;

import com.endava.spring.model.User;

import java.util.List;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
public interface UserService {

    List<User> listUsers();

    User findByUserName(String username);

    void saveUser(User user);

    User findByEmail(String email);

    void followUser(User user, User followedUser);

    void removeUser(int id);

    void updateUser(User user);

    User findById(int id);
}
