//package com.endava.spring.validator;
//
//import com.endava.spring.model.User;
//import com.endava.spring.service.UserService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.validation.Errors;
//import org.springframework.validation.ValidationUtils;
//import org.springframework.validation.Validator;
//
//
///**
// * Created by sbogdanschi on 8/05/2017.
// */
//public class ProfileEditValidator implements Validator {
//
//    private static final String EMAIL_REGEX = "^(?!\\.)(([^\\r\\\\]|\\\\[\\r\\\\])*|([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\\.)\\.)*)(?<!\\.)@[a-z0-9][\\w.-]*[a-z0-9]\\.[a-z][a-z.]*[a-z]$";
//
//    @Autowired
//    private UserService userService;
//
//    @Override
//    public boolean supports(Class<?> clazz) {
//        return User.class.equals(clazz);
//    }
//
//    @Override
//    public void validate(Object target, Errors errors) {
//        User user = (User) target;
//
//        User initialUser = user;
//        System.out.println(user.getId() + " -------------------------------------------");
//        if (user.getId() != 0) {
//            initialUser = userService.findByUsernameInitialized(user.getUsername());
//        }
//
//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "Required");
//        if (user.getFirstName().length() < 2 || user.getFirstName().length() > 32) {
//            errors.rejectValue("firstName", "Size.userForm.firstName");
//        }
//
//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "Required");
//        if (user.getLastName().length() < 2 || user.getLastName().length() > 32) {
//            errors.rejectValue("lastName", "Size.userForm.lastName");
//        }
//
//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "Required");
//        if ((userService.findByEmailInitialized(user.getEmail()) != null) ||
//                !initialUser.getEmail().equals(user.getEmail())) {
//            errors.rejectValue("email", "Duplicate.userForm.email");
//        }
//
//        if (!user.getEmail().matches(EMAIL_REGEX)) {
//            errors.rejectValue("email", "Wrong.userForm.email");
//        }
//
//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "Required");
//        if (user.getUsername().length() < 6 || user.getUsername().length() > 32) {
//            errors.rejectValue("username", "Size.userFrom.username");
//        }
//
//        if (userService.findByUsernameInitialized(user.getUsername()) != null ||
//                !initialUser.getUsername().equals(user.getUsername())) {
//            errors.rejectValue("username", "Duplicate.userForm.username");
//        }
//
//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "Required");
//        if (user.getPassword().length() < 8 || user.getPassword().length() > 32) {
//            errors.rejectValue("password", "Size.userForm.password");
//        }
//
//        if (!user.getConfirmPassword().equals(user.getPassword())) {
//            errors.rejectValue("confirmPassword", "Different.userForm.password");
//        }
//    }
//}
