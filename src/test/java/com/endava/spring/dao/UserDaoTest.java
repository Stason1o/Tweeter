package com.endava.spring.dao;

import com.endava.spring.configuration.*;
import com.endava.spring.model.User;

import org.junit.*;
import org.junit.runner.RunWith;

import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;


@ContextConfiguration(classes = {DataBaseConfiguration.class})
@RunWith(SpringJUnit4ClassRunner.class)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class UserDaoTest {

    @Autowired
    private UserDao userDao;

    @Autowired
    private ApplicationContext applicationContext;

    private User user;
    private int id;

    @Before
    @Transactional
    public void initUser(){
        user = new User();
        user.setUsername("KingPing");
        user.setPassword("YouKnowMy");
        user.setEmail("king@ping.com");
        user.setFirstName("BFG");
        user.setLastName("GFB");
        user.setEnabled(true);
        user.setImage("none");

        userDao.saveUser(user);
        id = user.getId();
    }

    @Test
    @Transactional
    public void TestA(){
        UserDao userDao = applicationContext.getBean("userDao", UserDao.class);
        assertNotNull(userDao);

        userDao = (UserDao) applicationContext.getBean("userDao");
        assertNotNull(userDao);
    }

    @Test
    @Transactional
    public void testB_SaveUser() {

        assertEquals(userDao.findByUserName("KingPing"), user);
    }

    @Test
    @Transactional
    public void testC_FindUserName(){
        user = userDao.findByUserName("KingPing");
        assertEquals(userDao.findByUserName("KingPing"), user);
    }

    @Test
    @Transactional
    public void testD_FindUserId(){
        user = userDao.findByUserName("KingPing");
        assertEquals(userDao.findById(id), user);
    }


    @Test
    @Transactional
    public void testE_EditUser(){
        user.setLastName("Mod");
        user.setFirstName("Dom");

        userDao.updateUser(user);
        assertEquals(userDao.findById(id), user);
    }

    @Test
    @Transactional
    public void testF_DellUser(){

        userDao.removeUser(id);
        assertNull(userDao.findById(id));
    }

}
