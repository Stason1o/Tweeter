package com.endava.spring.service.impl;

import com.endava.spring.dao.TweetDao;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import com.endava.spring.service.TweetService;
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
    public List<Tweet> listPaginatedTweets(int page) {
        return tweetDao.listPaginatedTweets(page);
    }

    @Override
    public int countPage() {
        return tweetDao.countPage();
    }

    @Override
    public List<Tweet> listTweets() {
        return tweetDao.listTweets();
    }

    @Override
    public Tweet getTweetById(int id) {
        return tweetDao.getTweetById(id);
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
