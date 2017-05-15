package com.endava.spring.service.impl;

import com.endava.spring.dao.TweetDao;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import com.endava.spring.service.TweetService;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
@Service("tweetService")
@Transactional
public class TweetServiceImpl implements TweetService {

    @Autowired
    private TweetDao tweetDao;

    @Override
    public void saveTweet(Tweet tweet, User user) {
        tweet.setDate(new Date());
        tweet.setUser(user);
        tweetDao.saveTweet(tweet);
    }

    @Override
    public void updateTweet(Tweet tweet, User user) {
        tweet.setDate(new Date());
        tweet.setUser(user);
        tweetDao.updateTweet(tweet);
    }

    @Override
    public void removeTweet(int id) {
        tweetDao.removeTweet(id);
    }

    @Override
    public List<Tweet> listPaginatedTweetsById(int id, int page) {
        int maxResults = 5 * page;
        int firstResult = maxResults - 5;

        if (page == 1){
            firstResult = 0;
        } else {
            maxResults = 5;
        }

        List<Tweet> list;
        if (id == 0){
            list = tweetDao.listPaginatedTweets(firstResult, maxResults);
        }else {
            list = tweetDao.listPaginatedTweetsByUserId(id, firstResult, maxResults);
        }

        for (Tweet tweet : list) {
            tweet = initializeTweet(tweet);
        }

        return list;
    }

    @Override
    public int countPage() {
        return tweetDao.countPage();
    }

    @Override
    public List<Tweet> listTweets() {
        List<Tweet> list = tweetDao.listTweets();
        for (Tweet tweet : list) {
            if (tweet != null){
                Hibernate.initialize(tweet.getUser());
            }
        }
        return list;
    }

    @Override
    public Tweet getTweetById(int id) {
        Tweet tweet = tweetDao.getTweetById(id);
        tweet = initializeTweet(tweet);
        return tweet;
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
    public void reTweet(Tweet tweet, User user, int id) {
        tweet.setTweet(tweetDao.getTweetById(id));
        saveTweet(tweet, user);
    }

    @Override
    public void commit(Tweet tweet, User user, int id) {
        tweet.setTweet(tweetDao.getTweetById(id));
        tweet.setComment(true);
        saveTweet(tweet, user);
    }

    @Override
    public List<Tweet> getTweetComment(int id) {
        List<Tweet> list = tweetDao.getTweetComment(id);
        for (Tweet tweet : list) {
            tweet = initializeTweet(tweet);
        }
        return list;
    }

    /*@Override
    public List<Tweet> getLikeList(int id, int page) {
        int maxResults = 5 * page;
        int firstResult = maxResults - 5;

        if (page == 1){
            firstResult = 0;
        } else {
            maxResults = 5;
        }

        List<Tweet> list;
        *//*if (id == 0){
            list = tweetDao.listPaginatedTweets(firstResult, maxResults);
        }else {*//*
            list = tweetDao.getLikeList(id, firstResult, maxResults);
        }

        for (Tweet tweet : list) {
            tweet = initializeTweet(tweet);
        }

        return list;
    }*/

    private Tweet initializeTweet(Tweet  tweet){
        if (tweet != null){
            Hibernate.initialize(tweet.getUser());
            Tweet retweet = tweet.getTweet();
            if (retweet != null) {
                Hibernate.initialize(retweet.getUser());
            }
        }
        return tweet;
    }
}
