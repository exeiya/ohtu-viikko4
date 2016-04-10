package ohtu.services;

import ohtu.domain.User;
import java.util.ArrayList;
import java.util.List;
import ohtu.data_access.UserDao;

public class AuthenticationService {

    private UserDao userDao;

    public AuthenticationService(UserDao userDao) {
        this.userDao = userDao;
    }

    public boolean logIn(String username, String password) {
        for (User user : userDao.listAll()) {
            if (checkMatch(user, username, password)) {
                return true;
            }
        }

        return false;
    }

    public boolean checkMatch(User user, String username, String password) {
        if (user.getUsername().equals(username)
                && user.getPassword().equals(password)) {
            return true;
        }
        return false;
    }

    public boolean createUser(String username, String password) {
        if (userDao.findByName(username) != null) {
            return false;
        }
        if (invalid(username, password)) {
            return false;
        }
        userDao.add(new User(username, password));
        return true;
    }

    private boolean invalid(String username, String password) {
        // validity check of username and password
        if (invalidUsername(username) || invalidPassword(password)) {
            return true;
        }
        return false;
    }

    private boolean invalidUsername(String username) {
        if (username.length() < 3 || username.matches(".*[^a-z].*")) {
            return true;
        }
        return false;
    }

    private boolean invalidPassword(String password) {
        if (password.length() < 8 || !password.matches(".*[0-9|'$&+,:;=?@#|.!].*")) {
            return true;
        }
        return false;
    }
}
