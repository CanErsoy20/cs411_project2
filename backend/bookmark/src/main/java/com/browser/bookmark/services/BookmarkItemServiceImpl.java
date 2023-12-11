package com.browser.bookmark.services;

import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.repositories.BookmarkItemRepository;
import com.browser.bookmark.repositories.BookmarkRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookmarkItemServiceImpl implements BookmarkItemService {
    private final BookmarkItemRepository bookmarkItemRepository;
    public BookmarkItemServiceImpl(BookmarkItemRepository bookmarkItemRepository) {
        this.bookmarkItemRepository = bookmarkItemRepository;
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
    public List<String> findLabels() {
        return bookmarkItemRepository.findLabels();
    }
}
