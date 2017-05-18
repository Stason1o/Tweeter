package com.endava.spring.service;

import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;

import java.util.List;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
public interface TweetService {
    void saveTweet(Tweet tweet, User user);

    List<Tweet> listTweets();

    //List<Tweet> listPaginatedTweets(int page);

    List<Tweet> listPaginatedTweetsById(int id, int page);

    int countPage(int id, boolean isUser);

    void updateTweet(Tweet tweet, User user);

    void removeTweet(int id);

    Tweet getTweetById(int id);

    void reTweet(Tweet tweet, User user, int id);

    void commit(Tweet tweet, User user, int id);

    /*List<Tweet> getLikeList(int id, int page);*/

    List<Tweet> getTweetComment(int id);

}
