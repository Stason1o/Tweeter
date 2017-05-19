package com.endava.spring.service.impl;

import com.endava.spring.dao.TweetDao;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import com.endava.spring.service.TweetService;
import org.apache.log4j.Logger;
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

    private final static Logger logger = Logger.getLogger(TweetServiceImpl.class);

    @Autowired
    private TweetDao tweetDao;

    @Override
    public void saveTweet(Tweet tweet, User user) {
        logger.info("Passing tweet to dao for saving");
        tweet.setDate(new Date());
        tweet.setUser(user);
        tweetDao.saveTweet(tweet);
        logger.info("Tweet successfully passed");
    }

    @Override
    public void updateTweet(Tweet tweet, User user) {
        logger.info("Passing tweet to dao for updating");
        tweet.setDate(new Date());
        tweet.setUser(user);
        tweetDao.updateTweet(tweet);
        logger.info("Tweet's successfully passed");
    }

    @Override
    public void removeTweet(int id) {
        logger.info("Passing tweet id to dao to remove");
        tweetDao.removeTweet(id);
        logger.info("Id is successfully passed");
    }

    @Override
    public List<Tweet> listPaginatedTweetsById(int id, int page, boolean isUser) {
        logger.info("Getting list of paginated tweets by id");
        int maxResults = 5 * page;
        int firstResult = maxResults - 5;

        if (page == 1){
            firstResult = 0;
        } else {
            maxResults = 5;
        }

        List<Tweet> list = tweetDao.listPaginatedTweetsByUserId(id, firstResult, maxResults, isUser);

        for (Tweet tweet : list) {
            tweet = initializeTweet(tweet);
        }

        logger.info("Returning list of paginated tweets by id");
        return list;
    }

    @Override
    public int countPage(int id, boolean isUser) {
        logger.info("Returning page count");
        return tweetDao.countPage(id, isUser);
    }

    @Override
    public List<Tweet> listTweets() {
        logger.info("Getting list of tweets");
        List<Tweet> list = tweetDao.listTweets();
        for (Tweet tweet : list) {
            if (tweet != null){
                Hibernate.initialize(tweet.getUser());
            }
        }
        logger.info("Returning list of tweets");
        return list;
    }

    @Override
    public Tweet getTweetById(int id) {
        logger.info("Getting tweet by id");
        Tweet tweet = tweetDao.getTweetById(id);
        tweet = initializeTweet(tweet);
        logger.info("Returning tweet");
        return tweet;
    }

    @Override
    public void reTweet(Tweet tweet, User user, int id) {
        logger.info("Re-tweeting tweet");
        tweet.setTweet(tweetDao.getTweetById(id));
        saveTweet(tweet, user);
        logger.info("Tweet is successfully re-tweeted");
    }

    @Override
    public void commit(Tweet tweet, User user, int id) {
        logger.info("Saving tweet comment");
        tweet.setTweet(tweetDao.getTweetById(id));
        tweet.setComment(true);
        saveTweet(tweet, user);
        logger.info("Tweet comment is passed to dao");
    }

    @Override
    public List<Tweet> getTweetComment(int id) {
        logger.info("Getting tweet comments");
        List<Tweet> list = tweetDao.getTweetComment(id);
        for (Tweet tweet : list) {
            tweet = initializeTweet(tweet);
        }
        logger.info("Tweet comments are successfully found!");
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
        logger.info("Initializing tweet");
        if (tweet != null){
            Hibernate.initialize(tweet.getUser());
            logger.info("Tweet user is initialized");
            Tweet retweet = tweet.getTweet();
            if (retweet != null) {
                Hibernate.initialize(retweet.getUser());
                logger.info("Re-tweet user is initialized");
            }
        }

        return tweet;
    }
}
