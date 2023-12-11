package com.browser.bookmark.services;

import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.models.Folder;
import com.browser.bookmark.models.User;
import com.browser.bookmark.repositories.BookmarkItemRepository;
import com.browser.bookmark.repositories.BookmarkRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class BookmarkItemServiceImpl implements BookmarkItemService {
    private final BookmarkItemRepository bookmarkItemRepository;
    private final UserService userService;
    public BookmarkItemServiceImpl(BookmarkItemRepository bookmarkItemRepository, UserService userService) {
        this.bookmarkItemRepository = bookmarkItemRepository;
        this.userService = userService;
    }
    @Override
    public BookmarkItem addBookmarkItem(BookmarkItem bookmarkItem) {
        return bookmarkItemRepository.save(bookmarkItem);
    }

    @Override
    public List<BookmarkItem> findAllBookmarkItems() {
        return bookmarkItemRepository.findAll();
    }

    @Override
    public BookmarkItem findBookmarkItemById(Long id) {
        Optional<BookmarkItem> bookmarkItem = bookmarkItemRepository.findById(id);
        if(bookmarkItem.isPresent()) {
            return bookmarkItem.get();
        } else {
            return null;
        }
    }

    @Override
    public void deleteBookmarkItemById(Long id) {
        Optional<BookmarkItem> bookmarkItem = bookmarkItemRepository.findById(id);
        if(bookmarkItem.isPresent()) {
            bookmarkItemRepository.deleteById(id);
        } else {
            throw new RuntimeException("BookmarkItem with id " + id + "doesn't exist.");
        }
    }

    @Override
    public List<BookmarkItem> findBookmarkItemsByLabel(String label) {
        return bookmarkItemRepository.findBookmarkItemsByLabel(label);
    }

    @Override
    public List<String> findLabels(Long id) {
        User user = userService.findUserById(id);
        if(user != null) {
            List<String> labels = new ArrayList<>();
            processBookmarkItems(user.getItems(), labels);
            return labels;
        }
        return null;
    }

    private void processBookmarkItems(List<BookmarkItem> items, List<String> labels) {
        for (BookmarkItem item : items) {
            if (item instanceof Bookmark) {
                addLabelIfNotExists(labels, item.getLabel());
            } else if (item instanceof Folder) {
                Folder folder = (Folder) item;
                addLabelIfNotExists(labels, item.getLabel());
                processBookmarkItems(folder.getItems(), labels);
            }
        }
    }

    private void addLabelIfNotExists(List<String> labels, String label) {
        if (label != null && !labels.contains(label)) {
            labels.add(label);
        }
    }
}
