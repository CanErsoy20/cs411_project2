package com.browser.bookmark.services;

import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface BookmarkItemService {
    BookmarkItem addBookmarkItem(BookmarkItem bookmarkItem);
    List<BookmarkItem> findAllBookmarkItems();
    BookmarkItem findBookmarkItemById(Long id);
    void deleteBookmarkItemById(Long id);
    List<BookmarkItem> findBookmarkItemsByLabel(String label);
}
