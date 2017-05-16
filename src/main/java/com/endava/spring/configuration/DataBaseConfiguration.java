package com.endava.spring.configuration;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

/**
 * Created by sbogdanschi on 25/04/2017.
 */
@Configuration
@EnableTransactionManagement
@ComponentScan("com.endava.spring.configuration")
@PropertySource(value = {"classpath:application.properties"})
@Import(WebConfiguration.class)
public class DataBaseConfiguration {

    private final static Logger logger = Logger.getLogger(DataBaseConfiguration.class);

    @Autowired
    private Environment environment;

    @Bean
    public DataSource dataSource(){
        logger.log(Level.INFO, "Initializing creation of dataSource bean");
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        try {
            dataSource.setDriverClassName(environment.getRequiredProperty("jdbc.driverClassName"));
            dataSource.setUrl(environment.getRequiredProperty("jdbc.url"));
            dataSource.setUsername(environment.getRequiredProperty("jdbc.username"));
            dataSource.setPassword(environment.getRequiredProperty("jdbc.password"));
        }catch (Exception ex){
            logger.log(Level.ERROR, ex);
            ex.printStackTrace();
        }
        logger.log(Level.INFO,"Creation of dataSource bean is successful. " +
                "Database: " + environment.getRequiredProperty("jdbc.driverClassName") +
                "Url: " + environment.getRequiredProperty("jdbc.url"));
        return dataSource;
    }

    @Bean
    public LocalSessionFactoryBean sessionFactory() {
        logger.log(Level.INFO, "Initializing creation of sessionFactory bean");
        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();

        try {
            sessionFactory.setDataSource(dataSource());
            sessionFactory.setPackagesToScan("com.endava.spring");
            sessionFactory.setHibernateProperties(hibernateProperties());
        }catch (Exception ex){
            logger.log(Level.ERROR, ex);
        }
        logger.log(Level.INFO, "Creation of sessionFactory bean is successful!");
        return sessionFactory;
    }

    private Properties hibernateProperties() {
        logger.log(Level.INFO, "Initialization of hibernate properties");
        Properties properties = new Properties();
        try {
            properties.put("hibernate.dialect", environment.getRequiredProperty("hibernate.dialect"));
            properties.put("hibernate.show_sql", environment.getRequiredProperty("hibernate.show_sql"));
            properties.put("hibernate.format_sql", environment.getRequiredProperty("hibernate.format_sql"));
//            properties.put("hibernate.temp.use_jdbc_metadata_defaults", environment.getRequiredProperty("hibernate.temp.use_jdbc_metadata_defaults"));
        }catch (Exception ex){
            logger.log(Level.ERROR, ex);
            ex.printStackTrace();
        }
        logger.log(Level.INFO, "Initialization of hibernate properties is successful!");
        return properties;
    }

    @Bean
    @Autowired
    public HibernateTransactionManager transactionManager(SessionFactory s) {
        logger.log(Level.INFO, "Initializing transaction manager");
        HibernateTransactionManager txManager = new HibernateTransactionManager();
        try {
            txManager.setSessionFactory(s);
        }catch (Exception ex){
            logger.log(Level.ERROR, ex);
            ex.printStackTrace();
        }
        logger.log(Level.INFO, "Initialization of transaction manager is successful!");
        return txManager;
    }
}
