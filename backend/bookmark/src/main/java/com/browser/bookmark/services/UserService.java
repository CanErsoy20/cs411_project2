package com.browser.bookmark.services;

import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.models.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {
    String hashPassword(String password);
    User addUser(User user);
    List<User> findAllUsers();
    User findUserById(Long id);
    User findUserByEmail(String email);
    void deleteUserById(Long id);
    boolean isValid(String password);
    boolean pwMatches(String typedPw, String password);
    boolean addBookmarkItemToUser(BookmarkItem bookmarkItem, Long id);
}
