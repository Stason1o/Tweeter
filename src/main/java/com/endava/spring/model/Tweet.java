package com.endava.spring.model;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.List;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
@Entity
@Table(name = "tweets")
public class Tweet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tweet_id")
    private int id;

    @Column(name = "tweet_content")
    @Size(max = 140, min = 1)
    private String content;

    @Column(name = "tweet_date", columnDefinition="DATETIME")
    @Temporal(value = TemporalType.TIMESTAMP)
    private Date date;

//    @Column(name = "tweet_type")
//    private int tweetType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_user")
    private User user;

    @OneToOne
    @JoinColumn(name = "retweet_id")
    private Tweet tweet;

    @Column(name = "is_comment")
    private boolean isComment;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.REFRESH)
    @JoinTable(name="tweet_likes", joinColumns = @JoinColumn(name = "tweet_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id"))
    private List<Tweet> tweetsLikes;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Tweet getTweet() {
        return tweet;
    }

    public void setTweet(Tweet tweet) {
        this.tweet = tweet;
    }

    public boolean isComment() {
        return isComment;
    }

    public void setComment(boolean comment) {
        isComment = comment;
    }

    public List<Tweet> getTweetsLikes() {
        return tweetsLikes;
    }

    public void setTweetsLikes(List<Tweet> tweetsComments) {
        this.tweetsLikes = tweetsComments;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Tweet)) return false;

        Tweet tweet1 = (Tweet) o;

        if (getId() != tweet1.getId()) return false;
        if (isComment() != tweet1.isComment()) return false;
        if (getContent() != null ? !getContent().equals(tweet1.getContent()) : tweet1.getContent() != null)
            return false;
        if (getDate() != null ? !getDate().equals(tweet1.getDate()) : tweet1.getDate() != null) return false;
        if (getUser() != null ? !getUser().equals(tweet1.getUser()) : tweet1.getUser() != null) return false;
        if (getTweet() != null ? !getTweet().equals(tweet1.getTweet()) : tweet1.getTweet() != null) return false;
        return getTweetsLikes() != null ? getTweetsLikes().equals(tweet1.getTweetsLikes()) : tweet1.getTweetsLikes() == null;

    }

    @Override
    public int hashCode() {
        int result = getId();
        result = 31 * result + (getContent() != null ? getContent().hashCode() : 0);
        result = 31 * result + (getDate() != null ? getDate().hashCode() : 0);
        result = 31 * result + (getUser() != null ? getUser().hashCode() : 0);
        result = 31 * result + (getTweet() != null ? getTweet().hashCode() : 0);
        result = 31 * result + (isComment() ? 1 : 0);
        result = 31 * result + (getTweetsLikes() != null ? getTweetsLikes().hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Tweet{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", date=" + date +
                ", user=" + user +
                ", tweet=" + tweet +
                ", isComment=" + isComment +
                ", tweetsLikes=" + tweetsLikes +
                '}';
    }
}
