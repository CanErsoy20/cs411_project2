package com.browser.bookmark.controllers;

import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.Folder;
import com.browser.bookmark.services.FolderService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("api/folder")
public class FolderController {
    FolderService folderService;

    public FolderController(FolderService folderService) {
        this.folderService = folderService;
    }

    @CrossOrigin(origins = "*")
    @PostMapping("/add")
    public Response addFolder(@RequestBody Folder folder) {
        try {
            Folder createdFolder = folderService.addFolder(folder);
            return new Response("Success", 200, createdFolder);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/all")
    public Response getAllFolders() {
        try {
            List<Folder> folders = folderService.findAllFolders();
            return new Response("Success", 200, folders);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/{id}")
    public Response getFolderById(@PathVariable("id") long id) {
        try {
            Folder foundFolder = folderService.findFolderById(id);
            return new Response("Success", 200, foundFolder);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @DeleteMapping("/{id}")
    public Response deleteFolderById(@PathVariable("id") long id) {
        try {
            folderService.deleteFolderById(id);
            return new Response("Success", 200, null);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @PostMapping("/add-to-folder/{id}")
    public Response addFolderToFolder(@RequestBody Folder folder, @PathVariable("id") long folderId) {
        try {
            if(folderService.addBookmarkItemToFolder(folder, folderId))
                return new Response("Success", 200, folder);
            return new Response("Could not add folder in folder", 200, null);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }
}
