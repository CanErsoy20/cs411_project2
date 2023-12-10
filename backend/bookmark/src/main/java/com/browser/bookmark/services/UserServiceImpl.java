package com.browser.bookmark.services;

import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.models.User;
import com.browser.bookmark.repositories.UserRepository;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    @Override
    public String hashPassword(String password) {
        try
        {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] bytes = md.digest();

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public User addUser(User user) {
        String hashedPw = hashPassword(user.getPassword());
        user.setPassword(hashedPw);
        return userRepository.save(user);
    }

    @Override
    public List<User> findAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public User findUserById(Long id) {
        Optional<User> user = userRepository.findById(id);
        if(user.isPresent()) {
            return user.get();
        } else {
            return null;
        }
    }

    @Override
    public User findUserByEmail(String email) {
        Optional<User> user = userRepository.findUserByEmail(email);
        if(user.isPresent()) {
            return user.get();
        } else {
            return null;
        }
    }

    @Override
    public void deleteUserById(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            userRepository.deleteById(id);
        } else {
            throw new RuntimeException("User with id " + id + "doesn't exist.");
        }
    }

    @Override
    public boolean isValid(String password) {
        return password.length() >= 3;
    }

    @Override
    public boolean pwMatches(String typedPw, String password) {
        String hash = hashPassword(typedPw);
        return hash.equals(password);
    }

    @Override
    public boolean addBookmarkItemToUser(BookmarkItem bookmarkItem, Long id) {
        User user = findUserById(id);
        if(user != null) {
            user.getItems().add(bookmarkItem);
            return true;
        } else {
            return false;
        }
    }
}
