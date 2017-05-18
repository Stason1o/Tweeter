package com.endava.spring.dao.impl;

import com.endava.spring.dao.UserDao;
import com.endava.spring.model.User;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
@Repository("userDao")
public class UserDaoImpl implements UserDao {

    private final static Logger logger = Logger.getLogger(UserDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;

    public List<User> listUsers() {
        logger.log(Level.INFO, "Creating list of all users");
        List<User> list = new ArrayList<>();
        try {
            list = sessionFactory.getCurrentSession().createQuery("from User").list();
        }catch (Exception ex){
            ex.printStackTrace();
            logger.log(Level.ERROR, ex);
        }
        logger.log(Level.INFO, "Returning list of all users from database");
        return list;
    }

    public List<User> listFollowedUsers(int id){
        logger.log(Level.INFO, "Initializing search of list by followed user");
        List<User> followedUsers = getFollowers(id);
        List<User> list = new ArrayList<>();

        try {
            if (followedUsers.size() == 0){
                logger.log(Level.WARN, "Empty list of followed users");
                return null;
            } else{
                list = sessionFactory.getCurrentSession().createQuery("from User where id in :idlist and id !=" + id)
                        .setParameterList("idlist", followedUsers).list();
                logger.log(Level.INFO, "Returning list of followed users");
            }
        } catch (Exception ex){
            logger.log(Level.ERROR,"Cannot extract the list of followed users", ex);
            ex.printStackTrace();
        }

        return list;
    }

    @Override
    public List<User> listUnfollowedUsers(int id) {
        logger.log(Level.INFO, "Initializing search of list by unfollowed user");
        List<User> followedUsers = getFollowers(id);
        List<User> list = new ArrayList<>();
        try {
            if (followedUsers.size() == 0) {
                list = sessionFactory.getCurrentSession().createQuery("from User where id !=" + id).list();
                logger.log(Level.INFO, "Returning list of all users except current User");
            } else {
                list = sessionFactory.getCurrentSession().createQuery("from User where id not in :idlist and id !=" + id)
                        .setParameterList("idlist", followedUsers).list();
                logger.log(Level.INFO, "Returning list of unfollowed users excluding followers");
            }
        } catch (Exception ex){
            logger.log(Level.ERROR,"Cannot extract the list of unfollowed users", ex);
            ex.printStackTrace();
        }
        return list;
    }

    private List<User> getFollowers(int id){
        logger.log(Level.INFO, "Creating list of followed users");
        String hql = "SELECT user_2_id FROM user_friends WHERE user_1_id = " + id;
        List<User> followedUsers = sessionFactory.getCurrentSession().createSQLQuery(hql).list();
        logger.log(Level.INFO, "Returning list of followed users");
        return followedUsers;
    }

    @Override
    public User findByUserName(String username) {
        logger.log(Level.INFO, "Initializing user search query by username");
        User user = (User) sessionFactory.getCurrentSession()
                .createQuery("from User where username = :username")
                .setString("username", username)
                .uniqueResult();
        logger.log(Level.INFO, "Returning user search query by username");
        return user;
    }

    @Override
    public void saveUser(User user) {
        logger.log(Level.INFO, "Saving user search query by username");
        sessionFactory.getCurrentSession().persist(user);
        logger.log(Level.INFO, "User's successfully saved!");
    }

    @Override
    public User findByEmail(String email) {
        logger.log(Level.INFO, "Initializing user search query by email");
        User user = (User) sessionFactory.getCurrentSession()
                .createQuery("from User where email = :email")
                .setString("email", email)
                .uniqueResult();
        logger.log(Level.INFO, "Returning user search query by email");
        return user;
    }

    @Override
    public void removeUser(int id) {
        logger.log(Level.INFO, "Removing user search query by username");
        Session session = sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, id);
        if (user != null) {
            session.delete(user);
            logger.log(Level.INFO, "User's successfully removed from database!");
        } else {
            logger.log(Level.INFO, "There is no such user in database");
        }
    }

    @Override
    public void updateUser(User user) {
//        System.err.println("MY WORST MISTAKE" + user);
        logger.log(Level.INFO, "Updating user");
        sessionFactory.getCurrentSession().update(user);
        logger.log(Level.INFO, "User's successfully updated");
    }

    @Override
    public User findById(int id) {
        logger.log(Level.INFO, "Initializing user by id");
        User user = (User) sessionFactory.getCurrentSession().get(User.class, id);
        logger.log(Level.INFO, "Returning user by id");
        return user;
    }

    @Override
    public List<User> searchByUsername(String username) {
        logger.log(Level.INFO, "Initializing list of users by username");
        List<User> list = sessionFactory.getCurrentSession()
                .createQuery("from User where username LIKE " +
                        ":startingUsername or username LIKE :middleUsername or username LIKE :endUsername" )
                .setParameter("startingUsername", username + "%")
                .setParameter("middleUsername", "%" + username + "%")
                .setParameter("endUsername", "%" + username).list();
        logger.log(Level.INFO, "Returning list of users by username");
        return list;
    }



//    @Override
//    public User searchByUsernameFirstNameLastName(String username, String firstName, String lastName) {
//        return (User)sessionFactory.getCurrentSession()
//                .createQuery("from User where username = :username " +
//                        "and firstName = :firstName and lastName = :lastName")
//                .setParameter("username", username)
//                .setParameter("firstName", firstName)
//                .setParameter("lastName", lastName).uniqueResult();
//    }
//
//    @Override
//    public User searchByUsernameFirstName(String username, String firstName) {
//        return (User)sessionFactory.getCurrentSession()
//                .createQuery("from User where username = :username and firstName = :firstName")
//                .setParameter("username", username)
//                .setParameter("firstName", firstName)
//                .uniqueResult();
//    }
//
//    @Override
//    public User searchByUsernameLastName(String username, String lastName) {
//        return (User)sessionFactory.getCurrentSession()
//                .createQuery("from User where username = :username and lastName = :lastName")
//                .setParameter("username", username)
//                .setParameter("lastName", lastName)
//                .uniqueResult();
//    }
//
//    @Override
//    public List<User> searchByFirstName(String firstName) {
//        return sessionFactory.getCurrentSession()
//                .createQuery("from User where firstName = :firstName")
//                .setParameter("firstName", firstName).list();
//    }
//
//    @Override
//    public List<User> searchByLastName(String lastName) {
//        return sessionFactory.getCurrentSession()
//                .createQuery("from User where lastName = :lastName")
//                .setString("lastName", lastName).list();
//    }
//
//    @Override
//    public User searchByFirstNameLastName(String firstName, String lastName) {
//        return (User)sessionFactory.getCurrentSession()
//                .createQuery("from User where firstName = :firstName and lastName = :lastName")
//                .setParameter("firstName", firstName)
//                .setParameter("lastName", lastName)
//                .uniqueResult();
//    }


}
