package com.browser.bookmark.controllers;

import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.services.BookmarkService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("api/bookmark")
public class BookmarkController {
    BookmarkService bookmarkService;

    public BookmarkController(BookmarkService bookmarkService) {
        this.bookmarkService = bookmarkService;
    }

    @CrossOrigin(origins = "*")
    @PostMapping("/add")
    public Response addBookmark(@RequestBody Bookmark bookmark) {
        try {
            Bookmark createdBookmark = bookmarkService.addBookmark(bookmark);
            return new Response("Success", 200, createdBookmark);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/all")
    public Response getAllBookmarks() {
        try {
            List<Bookmark> bookmarks = bookmarkService.findAllBookmarks();
            return new Response("Success", 200, bookmarks);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/{id}")
    public Response getBookmarkById(@PathVariable("id") long id) {
        try {
            Bookmark foundBookmark = bookmarkService.findBookmarkById(id);
            return new Response("Success", 200, foundBookmark);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @DeleteMapping("/{id}")
    public Response deleteBookmarkById(@PathVariable("id") long id) {
        try {
            bookmarkService.deleteBookmarkById(id);
            return new Response("Success", 200, null);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @PostMapping("/add-to-folder/{id}")
    public Response addBookmarkToFolder(@RequestBody Bookmark bookmark, @PathVariable("id") long folderId) {
        try {
            if(bookmarkService.assignBookmarkToFolder(bookmark, folderId))
                return new Response("Success", 200, bookmark);
            return new Response("Could not add bookmark to folder", 200, null);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }
}
