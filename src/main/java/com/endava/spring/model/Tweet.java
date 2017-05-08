package com.endava.spring.model;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.Objects;

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

    @Column(name = "tweet_date")
    @Temporal(value = TemporalType.DATE)
    private Date date;

//    @Column(name = "tweet_type")
//    private int tweetType;

    @ManyToOne/*(fetch = FetchType.LAZY)*/
    @JoinColumn(name = "id_user")
    private User user;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Tweet tweet = (Tweet) o;
        return id == tweet.id &&
                Objects.equals(content, tweet.content) &&
                Objects.equals(date, tweet.date) &&
                Objects.equals(user, tweet.user);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, content, date, user);
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Tweet{");
        sb.append("id=").append(id);
        sb.append(", content='").append(content).append('\'');
        sb.append(", date=").append(date);
        sb.append(", user=").append(user);
        sb.append('}');
        return sb.toString();
    }
}
