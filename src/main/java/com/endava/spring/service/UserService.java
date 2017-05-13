package com.endava.spring.service;

import com.endava.spring.model.User;

import java.util.List;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
public interface UserService {

    List<User> listInitializedUsers();

    List<User> listUsers();

    List<User> listUnfollowedUsers(int id);

    User findByUsernameInitialized(String username);

    User findByUsername(String username);

    void saveUser(User user);

    User findByEmailInitialized(String email);

    User findByEmail(String email);

    void followUser(User user, User followedUser);

    void removeUser(int id);

    void updateUser(User user);

    User findByIdInitialized(int id);

    User findById(int id);

    void unfollowUser(User user, User unfollowedUser);

    List<User> filterFollowedUsers(List<User> listOfAllUsers, User currentUser);

    List<User> listFollowedUsers(int id);

    void updateUserRole(int userId, int roleId);

    void updateUserState(int id);
}
