package com.browser.bookmark.services;

import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.Folder;
import com.browser.bookmark.repositories.BookmarkRepository;
import com.browser.bookmark.repositories.FolderRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookmarkServiceImpl implements BookmarkService {
    private final BookmarkRepository bookmarkRepository;
    private final FolderService folderService;
    private final UserService userService;
    public BookmarkServiceImpl(BookmarkRepository bookmarkRepository, FolderService folderService, UserService userService) {
        this.bookmarkRepository = bookmarkRepository;
        this.folderService = folderService;
        this.userService = userService;
    }
    @Override
    public Bookmark addBookmark(Bookmark bookmark) {
        if(userService.addBookmarkItemToUser(bookmark, bookmark.getUser().getUserId()))
            return bookmarkRepository.save(bookmark);
        return null;
    }

    @Override
    public List<Bookmark> findAllBookmarks() {
        return bookmarkRepository.findAll();
    }

    @Override
    public Bookmark findBookmarkById(Long id) {
        Optional<Bookmark> bookmark = bookmarkRepository.findById(id);
        if(bookmark.isPresent()) {
            return bookmark.get();
        } else {
            return null;
        }
    }

    @Override
    public void deleteBookmarkById(Long id) {
        Optional<Bookmark> bookmark = bookmarkRepository.findById(id);
        if(bookmark.isPresent()) {
            bookmarkRepository.deleteById(id);
        } else {
            throw new RuntimeException("Bookmark with id " + id + " doesn't exist.");
        }
    }

    @Override
    public boolean assignBookmarkToFolder(Bookmark bookmark, Long folderId) {
        if(folderService.addBookmarkItemToFolder(bookmark, folderId)) {
            bookmarkRepository.save(bookmark);
            return true;
        }
        return false;
    }
}
