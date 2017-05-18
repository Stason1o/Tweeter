package com.endava.spring.dao.impl;

import com.endava.spring.dao.TweetDao;
import com.endava.spring.model.Tweet;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
@Repository("tweetDao")
public class TweetDaoImpl implements TweetDao {

    private final static Logger logger = Logger.getLogger(TweetDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveTweet(Tweet tweet) {
        logger.info("Saving new tweet");
        try {
            sessionFactory.getCurrentSession().persist(tweet);
        }catch (Exception ex){
            logger.error(ex);
        }
        logger.info("Tweet is successfully saved!");
    }

    @Override
    public List<Tweet> listTweets() {
        logger.info("Extracting list of tweets from database");
        List<Tweet> list = sessionFactory.getCurrentSession().createQuery("from Tweet").list();
        logger.info("List is successfully extracted!");
        return list;
    }

    @Override
    public void removeTweet(int id) {
        logger.info("Deleting tweet..");
        try {
            Session session = sessionFactory.getCurrentSession();
            Tweet tweet = (Tweet) session.load(Tweet.class, id);
            if (tweet != null) {
                session.delete(tweet);
                logger.info("Tweet is successfully deleted!");
            }
        }catch (Exception e){
            logger.error(e);
        }
    }

    @Override
    public void updateTweet(Tweet tweet) {
        logger.info("Updating tweet!");
        sessionFactory.getCurrentSession().update(tweet);
        logger.info("Tweet is successfully updated");
    }

    @Override
    public Tweet getTweetById(int id) {
        logger.info("Extracting tweet by id");
        Tweet tweet = (Tweet) sessionFactory.getCurrentSession().get(Tweet.class, id);
        logger.info("Tweet is successfully extracted");
        return tweet;
    }

    @Override
    public int countPage() {
        logger.info("Retrieving information for page count ");
        int lastPageNumber = 0;
        try {
            Query query = sessionFactory.getCurrentSession().createQuery("select count (t.id) from Tweet t where isComment = false");
            Long countResults = (Long) query.uniqueResult();
            int pageSize = 5;
            lastPageNumber = (int) ((countResults / pageSize) + 1);
            logger.info("Information is successfully retrieved");
        } catch (Exception e){
            logger.error(e);
            e.printStackTrace();
        }
        logger.info("Retrieving is successful");
        return lastPageNumber;
    }

    @Override
    public List<Tweet> listPaginatedTweets(int firstResult, int maxResults) {
        logger.info("Retrieving list of paginated tweets");
        List<Tweet> list = new ArrayList<>();
        try {
            Query query = sessionFactory.getCurrentSession().createQuery("from Tweet order where isComment = false order by date desc");
            query.setFirstResult(firstResult);
            query.setMaxResults(maxResults);
            list = (List<Tweet>) query.list();
            logger.info("List of paginated tweets is successfully retrieved");
        }catch (Exception e){
            logger.error(e);
            e.printStackTrace();
        }
        return list;
    }


    @Override
    public List<Tweet> listPaginatedTweetsByUserId(int id, int firstResult, int maxResults) {
        logger.info("Retrieving list paginated tweets by user id");
        List<Tweet> list = new ArrayList<>();
        try {
            Query query = sessionFactory.getCurrentSession().createQuery("from Tweet where user =" + id + " and isComment = false order by date desc");
            query.setFirstResult(firstResult);
            query.setMaxResults(maxResults);

            list = (List<Tweet>) query.list();
            logger.info("List paginated tweets by user id is successfully retrieved");
        }catch (Exception e){
            logger.error(e);
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Tweet> getTweetComment(int id) {
        logger.info("Retrieving tweet comment");
        List<Tweet> list = new ArrayList<>();
        try {
            Query query = sessionFactory.getCurrentSession().createQuery("from Tweet where tweet =" + id + " and isComment = true order by date desc");
            list = (List<Tweet>) query.list();
            logger.info("Tweet comment is successfully retrieved");
        }catch (Exception e){
            logger.error(e);
            e.printStackTrace();
        }
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
