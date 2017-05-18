package com.endava.spring.validator;

import com.endava.spring.model.User;
import com.endava.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Created by sbogdanschi on 4/05/2017.
 */
@Component
public class RegistrationInputValidator implements Validator {

    private static final String EMAIL_REGEX = "^(?!\\.)(([^\\r\\\\]|\\\\[\\r\\\\])*|([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\\.)\\.)*)(?<!\\.)@[a-z0-9][\\w.-]*[a-z0-9]\\.[a-z][a-z.]*[a-z]$";
    private static final String EMAIL_FIELD = "email";
    private static final String PASSWORD_FIELD = "password";
    private static final String USERNAME_FIELD = "username";

    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;
        User initialUser = user;


        if (user.getId() != 0) {
            initialUser = userService.findById(user.getId());

            ValidationUtils.rejectIfEmptyOrWhitespace(errors, EMAIL_FIELD, "Required");
            if (userService.findByEmail(user.getEmail()) != null &&
                    !initialUser.getEmail().equals(user.getEmail())) {
                errors.rejectValue(EMAIL_FIELD, "Duplicate.userForm.email");
            }

            if (userService.findByUsername(user.getUsername()) != null &&
                !initialUser.getUsername().equals(user.getUsername())) {
                errors.rejectValue(USERNAME_FIELD, "Duplicate.userForm.username");
            }
        } else {

            ValidationUtils.rejectIfEmptyOrWhitespace(errors, EMAIL_FIELD, "Required");
            if (userService.findByEmail(user.getEmail()) != null) {
                errors.rejectValue(EMAIL_FIELD, "Duplicate.userForm.email");
            }

            if (userService.findByUsername(user.getUsername()) != null) {
                errors.rejectValue(USERNAME_FIELD, "Duplicate.userForm.username");
            }
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "Required");
        if (user.getFirstName().length() < 2 || user.getFirstName().length() > 32) {
            errors.rejectValue("firstName", "Size.userForm.firstName");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "Required");
        if (user.getLastName().length() < 2 || user.getLastName().length() > 32) {
            errors.rejectValue("lastName", "Size.userForm.lastName");
        }

        if (!user.getEmail().matches(EMAIL_REGEX)) {
            errors.rejectValue(EMAIL_FIELD, "Wrong.userForm.email");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, USERNAME_FIELD, "Required");
        if (user.getUsername().length() < 6 || user.getUsername().length() > 32) {
            errors.rejectValue(USERNAME_FIELD, "Size.userFrom.username");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, PASSWORD_FIELD, "Required");
        if (user.getPassword().length() < 8 || user.getPassword().length() > 32) {
            errors.rejectValue(PASSWORD_FIELD, "Size.userForm.password");
        }

        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Different.userForm.password");
        }
    }
}
