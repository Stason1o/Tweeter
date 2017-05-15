package com.endava.spring.model;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.Objects;

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

//    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.REFRESH)
//    @JoinTable(name="tweet_likes", joinColumns = @JoinColumn(name = "tweet_id"),
//            inverseJoinColumns = @JoinColumn(name = "user_id"))
//    private List<Tweet> tweetsLikes;

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

//    public List<Tweet> getTweetsLikes() {
//        return tweetsLikes;
//    }
//
//    public void setTweetsLikes(List<Tweet> tweetsComments) {
//        this.tweetsLikes = tweetsComments;
//    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Tweet tweet1 = (Tweet) o;
        return id == tweet1.id &&
                isComment == tweet1.isComment &&
                Objects.equals(content, tweet1.content) &&
                Objects.equals(date, tweet1.date) &&
                Objects.equals(user, tweet1.user) &&
                Objects.equals(tweet, tweet1.tweet);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, content, date, user, tweet, isComment);
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Tweet{");
        sb.append("id=").append(id);
        sb.append(", content='").append(content).append('\'');
        sb.append(", date=").append(date);
        sb.append(", user=").append(user);
        sb.append(", tweet=").append(tweet);
        sb.append(", isComment=").append(isComment);
        sb.append('}');
        return sb.toString();
    }
}
