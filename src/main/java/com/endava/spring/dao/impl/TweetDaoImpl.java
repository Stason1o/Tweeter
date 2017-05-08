package com.endava.spring.dao.impl;

import com.endava.spring.dao.TweetDao;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
@Repository("tweetDao")
public class TweetDaoImpl implements TweetDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveTweet(Tweet tweet) {
        sessionFactory.getCurrentSession().persist(tweet);
    }

    @Override
    public List<Tweet> listTweets() {
        List<Tweet> list = sessionFactory.getCurrentSession().createQuery("from Tweet").list();
        for (Tweet tweet : list) {
            if (tweet != null){
                Hibernate.initialize(tweet.getUser());
            }
        }

        return list;
    }

    @Override
    public Tweet getTweetById(int id) {
        return null;
    }

    @Override
    public Tweet getTweetByUserId(int id) {
        return null;
    }

    @Override
    public Tweet getTweetByUsername(String username) {
        return null;
    }

    @Override
    public Tweet getTweetByUser(User user) {
        return null;
    }

}
