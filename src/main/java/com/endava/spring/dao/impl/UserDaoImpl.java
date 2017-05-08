package com.endava.spring.dao.impl;

import com.endava.spring.dao.UserDao;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import org.hibernate.Hibernate;
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
        for (User user :list) {
            if(user != null){
                Hibernate.initialize(user.getTweets());
            }
        }
        return list;
    }

    @Override
    public User findByUserName(String username) {
        User user = (User) sessionFactory.getCurrentSession()
                .createQuery("from User where username = :username")
                .setString("username", username)
                .uniqueResult();
        if (user != null) {
            System.out.println("initializing in findByUserName");
            Hibernate.initialize(user.getTweets());
            Hibernate.initialize(user.getRoles());
        }
        return user;
    }

    @Override
    public void saveUser(User user) {
        sessionFactory.getCurrentSession().persist(user);
    }

    @Override
    public User findByEmail(String email) {
        User user = (User) sessionFactory.getCurrentSession()
                .createQuery("from User where email = :email")
                .setString("email", email)
                .uniqueResult();
        if (user != null) {
            System.out.println("initializing in findByEmail");
            Hibernate.initialize(user.getTweets());
            Hibernate.initialize(user.getRoles());
        }
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
        System.out.println("in update user DAO: " + user);
        sessionFactory.getCurrentSession().update(user);
    }

    @Override
    public User findById(int id) {
        User user = (User) sessionFactory.getCurrentSession().get(User.class, id);
        if (user != null) {
            System.out.println("initializing in findById");
            Hibernate.initialize(user.getTweets());
            Hibernate.initialize(user.getRoles());
        }
        return user;
    }

    @Override
    public User findUserById(int id) {
        String query = "from User where id=" + id;
        User user = (User) sessionFactory.getCurrentSession().createQuery(query).list();
        return user;
    }
}
