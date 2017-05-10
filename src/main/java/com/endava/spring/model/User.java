package com.endava.spring.model;

import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.*;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
@Entity
@DynamicUpdate
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int id;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "email")
    private String email;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "enabled")
    private boolean enabled;

    @Transient
    private boolean isFollowed;

    @Transient
    private String confirmPassword;

    @Transient
    private String oldEmail;

    public User() {
    }

    @OneToMany(mappedBy = "user", cascade = CascadeType.REFRESH,
            orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Tweet> tweets;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.REFRESH)
    @JoinTable(name = "user_roles", joinColumns = @JoinColumn(name = "id_user"),
            inverseJoinColumns = @JoinColumn(name = "id_role"))
    private Set<Role> roles = new HashSet<>(0);

    @ManyToMany(fetch = FetchType.LAZY,cascade = CascadeType.REFRESH)
    @JoinTable(name="user_friends", joinColumns = @JoinColumn(name = "user_1_id"),
            inverseJoinColumns = @JoinColumn(name = "user_2_id"))
    private List<User> followedUsers;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Set<Role> getRoles() {
        return this.roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public List<Tweet> getTweets() {
        return tweets;
    }

    public void setTweets(List<Tweet> tweets) {
        this.tweets = tweets;
    }

    public List<User> getFollowedUsers() {
        return followedUsers;
    }

    public void setFollowedUsers(List<User> followedUsers) {
        this.followedUsers = followedUsers;
    }

    public boolean isFollowed() {
        return isFollowed;
    }

    public void setFollowed(boolean followed) {
        isFollowed = followed;
    }

    public String getOldEmail() {

        return oldEmail;
    }

    public void setOldEmail(String oldEmail) {
        this.oldEmail = oldEmail;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("User{");
        sb.append("id=").append(id);
        sb.append(", username='").append(username).append('\'');
        sb.append(", password='").append(password).append('\'');
        sb.append(", email='").append(email).append('\'');
        sb.append(", firstName='").append(firstName).append('\'');
        sb.append(", lastName='").append(lastName).append('\'');
        sb.append(", enabled=").append(enabled);
        sb.append(", isFollowed=").append(isFollowed);
        sb.append(", confirmPassword='").append(confirmPassword).append('\'');
        sb.append(", oldEmail='").append(oldEmail).append('\'');
        sb.append(", tweets=").append(tweets);
        sb.append(", roles=").append(roles);
        sb.append(", followedUsers=").append(followedUsers);
        sb.append('}');
        return sb.toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id == user.id &&
                enabled == user.enabled &&
                isFollowed == user.isFollowed &&
                Objects.equals(username, user.username) &&
                Objects.equals(password, user.password) &&
                Objects.equals(email, user.email) &&
                Objects.equals(firstName, user.firstName) &&
                Objects.equals(lastName, user.lastName) &&
                Objects.equals(confirmPassword, user.confirmPassword) &&
                Objects.equals(oldEmail, user.oldEmail) &&
                Objects.equals(tweets, user.tweets) &&
                Objects.equals(roles, user.roles) &&
                Objects.equals(followedUsers, user.followedUsers);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, username, password, email, firstName, lastName, enabled, isFollowed, confirmPassword, oldEmail, tweets, roles, followedUsers);
    }



}
