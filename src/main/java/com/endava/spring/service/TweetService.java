package com.endava.spring.service;

import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;

import java.util.List;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
public interface TweetService {
    void saveTweet(Tweet tweet);

    List<Tweet> listTweets();

    Tweet getTweetById(int id);

    Tweet getTweetByUserId(int id);

    Tweet getTweetByUsername(String username);

    Tweet getTweetByUser(User user);
}
