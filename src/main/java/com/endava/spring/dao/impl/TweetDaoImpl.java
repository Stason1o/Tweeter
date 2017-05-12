package com.endava.spring.dao.impl;

import com.endava.spring.dao.TweetDao;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import org.hibernate.*;
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
    public void removeTweet(int id) {
        Session session = sessionFactory.getCurrentSession();
        Tweet tweet = (Tweet) session.load(Tweet.class, id);
        if (tweet != null) {
            session.delete(tweet);
        }
    }

    @Override
    public void updateTweet(Tweet tweet) {
        sessionFactory.getCurrentSession().update(tweet);
    }

    @Override
    public Tweet getTweetById(int id) {
        return (Tweet) sessionFactory.getCurrentSession().get(Tweet.class, id);
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


    @Override
    public int countPage() {

        Query query = sessionFactory.getCurrentSession().createQuery("select count (t.id) from Tweet t");
        Long countResults = (Long) query.uniqueResult();
        int pageSize = 5;
        int lastPageNumber = (int) ((countResults / pageSize) + 1);
        return lastPageNumber;
    }

    @Override
    public List<Tweet> listPaginatedTweets(int page) {

        int maxResults = 5 * page;
        int firstResult = maxResults - 5;
        Query query = sessionFactory.getCurrentSession().createQuery("from Tweet order by date desc ");
        query.setFirstResult(firstResult);
        if (page == 1){
            query.setMaxResults(maxResults);
        } else {
            query.setMaxResults(firstResult);
        }

        List<Tweet> list = (List<Tweet>)query.list();
        for (Tweet tweet : list) {
            if (tweet != null){
                Hibernate.initialize(tweet.getUser());
            }
        }
        return list;
    }
}
