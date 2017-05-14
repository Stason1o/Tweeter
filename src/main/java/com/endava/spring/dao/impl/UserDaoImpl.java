package com.endava.spring.dao.impl;

import com.endava.spring.dao.UserDao;
import com.endava.spring.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
@Repository("userDao")
public class UserDaoImpl implements UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    public List<User> listUsers() {
        List<User> list = sessionFactory.getCurrentSession().createQuery("from User").list();
        return list;
    }

    public List<User> listFollowedUsers(int id){
        String hql = "SELECT user_2_id FROM user_friends WHERE user_1_id = " + id;
        List<User> followedUsers = sessionFactory.getCurrentSession().createSQLQuery(hql).list();
        List<User> list;
        if(followedUsers != null) {
            list = sessionFactory.getCurrentSession().createQuery("from User where id in :idlist")
                    .setParameterList("idlist", followedUsers).list();
            return list;
        }
        return null;
    }

    @Override
    public List<User> listUnfollowedUsers(int id) {
        String hql = "SELECT user_2_id FROM user_friends WHERE user_1_id = " + id;
        List<User> followedUsers = sessionFactory.getCurrentSession().createSQLQuery(hql).list();
        List<User> list = sessionFactory.getCurrentSession().createQuery("from User where id not in :idlist and id !=" + id)
                .setParameterList("idlist", followedUsers).list();
        return list;
    }

    @Override
    public User findByUserName(String username) {
        User user = (User) sessionFactory.getCurrentSession()
                .createQuery("from User where username = :username")
                .setString("username", username)
                .uniqueResult();
        return user;
    }

    @Override
    public void saveUser(User user) {
        sessionFactory.getCurrentSession().persist(user);
//        user.getRoles().add(new Role(2, "ROLE_USER"));
//        sessionFactory.getCurrentSession().update(user);
    }

    @Override
    public User findByEmail(String email) {
        User user = (User) sessionFactory.getCurrentSession()
                .createQuery("from User where email = :email")
                .setString("email", email)
                .uniqueResult();
        return user;
    }

    @Override
    public void removeUser(int id) {
        Session session = sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, id);
        if (user != null) {
            session.delete(user);
        }
    }

    @Override
    public void updateUser(User user) {
//        System.err.println("MY WORST MISTAKE" + user);
        sessionFactory.getCurrentSession().update(user);
    }

    @Override
    public User findById(int id) {
        User user = (User) sessionFactory.getCurrentSession().get(User.class, id);
        return user;
    }

    @Override
    public List<User> searchByUsername(String username) {
        return sessionFactory.getCurrentSession()
                .createQuery("from User where username LIKE " +
                        ":startingUsername or username LIKE :middleUsername or username LIKE :endUsername" )
                .setParameter("startingUsername", username + "%")
                .setParameter("middleUsername", "%" + username + "%")
                .setParameter("endUsername", "%" + username).list();
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
