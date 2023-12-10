package com.browser.bookmark.services;

import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.models.Folder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface FolderService {
    Folder addFolder(Folder folder);
    List<Folder> findAllFolders();
    Folder findFolderById(Long id);
    void deleteFolderById(Long id);
    boolean addBookmarkItemToFolder(BookmarkItem bookmarkItem, Long id);
}
