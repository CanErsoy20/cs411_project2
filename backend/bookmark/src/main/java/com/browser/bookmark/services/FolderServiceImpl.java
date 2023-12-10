package com.browser.bookmark.services;

import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.models.Folder;
import com.browser.bookmark.models.User;
import com.browser.bookmark.repositories.BookmarkRepository;
import com.browser.bookmark.repositories.FolderRepository;
import com.browser.bookmark.repositories.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FolderServiceImpl implements FolderService {
    private final FolderRepository folderRepository;
    private final UserService userService;
    public FolderServiceImpl(FolderRepository folderRepository, UserService userService) {
        this.folderRepository = folderRepository;
        this.userService = userService;
    }
    @Override
    public Folder addFolder(Folder folder) {
        if(userService.addBookmarkItemToUser(folder, folder.getUser().getUserId()))
            return folderRepository.save(folder);
        return null;
    }

    @Override
    public List<Folder> findAllFolders() {
        return folderRepository.findAll();
    }

    @Override
    public Folder findFolderById(Long id) {
        Optional<Folder> folder = folderRepository.findById(id);
        if(folder.isPresent()) {
            return folder.get();
        } else {
            return null;
        }
    }

    @Override
    public void deleteFolderById(Long id) {
        Optional<Folder> folder = folderRepository.findById(id);
        if(folder.isPresent()) {
            folderRepository.deleteById(id);
        } else {
            throw new RuntimeException("Folder with id " + id + "doesn't exist.");
        }
    }

    @Override
    public boolean addBookmarkItemToFolder(BookmarkItem bookmarkItem, Long id) {
        Folder folder = findFolderById(id);
        if(folder != null) {
            folder.getItems().add(bookmarkItem);
            folderRepository.save(folder);
            return true;
        } else {
            return false;
        }
    }
}
