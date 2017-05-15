package com.endava.spring.dao;

import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;

import java.util.List;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
public interface TweetDao {

    void saveTweet(Tweet tweet);

    List<Tweet> listTweets();

    List<Tweet> listPaginatedTweets(int firstResult, int maxResults);

    List<Tweet> listPaginatedTweetsByUserId(int id, int firstResult, int maxResults);

    int countPage();

    void updateTweet(Tweet tweet);

    void removeTweet(int id);

    Tweet getTweetById(int id);

    /*List<Tweet> getLikeList(int id, int firstResult, int maxResults);*/

    List<Tweet> getTweetComment(int id);

    Tweet getTweetByUserId(int id);

    Tweet getTweetByUsername(String username);

    Tweet getTweetByUser(User user);

}
