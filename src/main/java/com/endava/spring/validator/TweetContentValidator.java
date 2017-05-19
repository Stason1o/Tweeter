package com.endava.spring.validator;

import com.endava.spring.model.Tweet;
import com.endava.spring.model.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Created by sbogdanschi on 19/05/2017.
 */
@Component
public class TweetContentValidator implements Validator{

    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Tweet tweet = (Tweet) target;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "Required");
        if (tweet.getContent().length() < 1 || tweet.getContent().length() > 140) {
            errors.rejectValue("content", "Size.tweet.content");
        }

    }


}
