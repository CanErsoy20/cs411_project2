package com.browser.bookmark.services;

import com.browser.bookmark.models.Bookmark;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface BookmarkService {
    Bookmark addBookmark(Bookmark bookmark);
    List<Bookmark> findAllBookmarks();
    Bookmark findBookmarkById(Long id);
    void deleteBookmarkById(Long id);
    boolean assignBookmarkToFolder(Bookmark bookmark, Long folderId);
}
