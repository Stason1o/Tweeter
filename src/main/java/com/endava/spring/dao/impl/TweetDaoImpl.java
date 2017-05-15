package com.endava.spring.dao.impl;

import com.endava.spring.dao.TweetDao;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
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
        Query query = sessionFactory.getCurrentSession().createQuery("select count (t.id) from Tweet t where isComment = false");
        Long countResults = (Long) query.uniqueResult();
        int pageSize = 5;
        int lastPageNumber = (int) ((countResults / pageSize) + 1);
        return lastPageNumber;
    }

    @Override
    public List<Tweet> listPaginatedTweets(int firstResult, int maxResults) {
        Query query = sessionFactory.getCurrentSession().createQuery("from Tweet order where isComment = false order by date desc");
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);

        List<Tweet> list = (List<Tweet>)query.list();

        return list;
    }


    @Override
    public List<Tweet> listPaginatedTweetsByUserId(int id, int firstResult, int maxResults) {
        Query query = sessionFactory.getCurrentSession().createQuery("from Tweet where user =" + id + " and isComment = false order by date desc");
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);

        List<Tweet> list = (List<Tweet>)query.list();

        return list;
    }


    @Override
    public List<Tweet> getTweetComment(int id) {
        Query query = sessionFactory.getCurrentSession().createQuery("from Tweet where tweet =" + id + " and isComment = true order by date desc");
        List<Tweet> list = (List<Tweet>)query.list();
        return list;
    }

    /*@Override
    public List<Tweet> getLikeList(int id, int firstResult, int maxResults) {

        Query query = sessionFactory.getCurrentSession().createQuery("from Tweet order where isComment = false order by date desc");
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);
        List<Tweet> tweet = (List<Tweet>)query.list();

        List<Integer> listed = new ArrayList<>();
        for (Tweet tw : tweet) {
            listed.add(tw.getId());
        }

        Query query3 = sessionFactory.getCurrentSession().createSQLQuery("SELECT tweet_id FROM tweet_likes WHERE tweet_id in :listed");
        query3.setParameterList("listed", listed);
        *//*Query query2 = sessionFactory.getCurrentSession().createQuery("SELECT tweet_id FROM tweet_likes WHERE tweet_id in :listed");
        query2.setParameterList("listed", listed);*//*

        List<Tweet> likeList = (List<Tweet>)query3.list();

        return likeList;
    }*/
}
