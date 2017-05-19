package com.endava.spring.dao;

import com.endava.spring.model.User;

import java.util.List;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
public interface UserDao {

    List<User> listUsers();

    List<User> listFollowedUsers(int id);

    List<User> listUnfollowedUsers(int id);

    User findByUserName(String username);

    void saveUser(User user);

    User findByEmail(String email);

    void removeUser(int id);

    void updateUser(User user);

    User findById(int id);

    List<User> searchByUsername(String username);

    List<User> listPaginatedUsersByUserId(int id, int firstResult, int maxResults, int typeOfList);

    int countPage(int id, int typeOfList);

//    User searchByUsernameFirstNameLastName(String username, String firstName, String lastName);
//
//    User searchByUsernameFirstName(String username, String firstName);
//
//    User searchByUsernameLastName(String username, String lastName);
//
//    List<User> searchByFirstName(String firstName);
//
//    List<User> searchByLastName(String lastName);
//
//    User searchByFirstNameLastName(String firstName, String lastName);

}
