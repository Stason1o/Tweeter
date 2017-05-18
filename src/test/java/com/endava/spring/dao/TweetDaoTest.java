package com.endava.spring.dao;

import com.endava.spring.configuration.DataBaseConfiguration;
import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import org.junit.*;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

import static org.junit.Assert.*;

@ContextConfiguration(classes = {DataBaseConfiguration.class})
@RunWith(SpringJUnit4ClassRunner.class)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class TweetDaoTest {

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private TweetDao tweetDao;

    @Autowired
    private UserDao userDao;

    private  Tweet tweet;
    private  User user;
    private  int id;
    private  String content;

    @Before
    public void setUp() {

        content = "My first Tweety!!!";

        user = new User();
        user.setUsername("TweetMan");
        user.setPassword("IWantToTweet");
        user.setEmail("ttwww@eeettt.com");
        user.setFirstName("Tweety");
        user.setLastName("Twit");
        user.setEnabled(true);
        user.setImage("none");

        tweet = new Tweet();
        tweet.setContent("Hello my first Tweety!!!");
        tweet.setDate(new Date());
        tweet.setUser(user);
        tweet.setTweet(null);
        tweet.setComment(false);

        userDao.saveUser(user);
        tweetDao.saveTweet(tweet);
        id = tweet.getId();

    }


    @Test
    @Transactional
    public void TestA(){
        TweetDao tweetDao = applicationContext.getBean("tweetDao", TweetDao.class);
        assertNotNull(tweetDao);

        tweetDao = (TweetDao) applicationContext.getBean("tweetDao");
        assertNotNull(tweetDao);
    }

    @Test
    @Transactional
    public void testB_SaveTweet() {
        assertNotNull(tweetDao.getTweetById(id));
        assertEquals(tweetDao.getTweetById(tweet.getId()), tweet);
    }

    @Test
    @Transactional
    public void testC_GetTweetById() {
        assertEquals(tweetDao.getTweetById(id).getId(), id);
    }

    @Test
    @Transactional
    public void testD_UpdateTweet() {
        tweet.setContent(content);
        tweetDao.updateTweet(tweet);
        assertEquals(tweetDao.getTweetById(id).getContent(),content);
    }

    @Test
    @Transactional
    public void testE_RemoveTweet() {
        tweetDao.removeTweet(id);
        assertNull(tweetDao.getTweetById(id));
    }

}