package com.endava.spring.configuration;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.endava.spring")
public class WebConfiguration extends WebMvcConfigurerAdapter{

    private final static Logger logger = Logger.getLogger(WebConfiguration.class);
    @Bean
    public ViewResolver viewResolver(){
        logger.info("Creating view resolver bean");
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        logger.info("Creation of view resolver is successful");
        return viewResolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        logger.info("Adding resource handlers..");
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
        logger.info("Successfully added..");
    }

    @Bean
    public MessageSource messageSource(){
        logger.info("Creating message source bean.");
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("WEB-INF/classes/messages");
        messageSource.setFallbackToSystemLocale(false);
        logger.info("Creation of message source bean is successful");
        return messageSource;
    }

}
