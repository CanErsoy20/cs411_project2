package com.browser.bookmark.controllers;

import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.services.BookmarkItemService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("api/bookmark/item")
public class BookmarkItemController {
    BookmarkItemService bookmarkItemService;
    public BookmarkItemController(BookmarkItemService bookmarkItemService) {
        this.bookmarkItemService = bookmarkItemService;
    }

    @CrossOrigin(origins = "*")
    @PostMapping("/add")
    public Response addBookmarkItem(@RequestBody BookmarkItem bookmarkItem) {
        try {
            BookmarkItem createdItem = bookmarkItemService.addBookmarkItem(bookmarkItem);
            return new Response("Success", 200, createdItem);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/all")
    public Response getAllBookmarkItems() {
        try {
            List<BookmarkItem> items = bookmarkItemService.findAllBookmarkItems();
            return new Response("Success", 200, items);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/{id}")
    public Response getBookmarkItemById(@PathVariable("id") long id) {
        try {
            BookmarkItem foundItem = bookmarkItemService.findBookmarkItemById(id);
            return new Response("Success", 200, foundItem);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @DeleteMapping("/{id}")
    public Response deleteBookmarkById(@PathVariable("id") long id) {
        try {
            bookmarkItemService.deleteBookmarkItemById(id);
            return new Response("Success", 200, null);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping
    public Response getAllBookmarkItems(@RequestParam("label") String label) {
        try {
            List<BookmarkItem> items = bookmarkItemService.findBookmarkItemsByLabel(label);
            return new Response("Success", 200, items);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/labels/{id}")
    public Response getLabels(@PathVariable("id") long id) {
        try {
            List<String> labels = bookmarkItemService.findLabels(id);
            return new Response("Success", 200, labels);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping
    public Response getSomeBookmarkItems(@RequestParam("label") String label) {
        try {
            List<BookmarkItem> items = bookmarkItemService.findBookmarks(label);
            return new Response("Success", 200, items);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping
    public Response getSomeFolders() {
        try {
            List<BookmarkItem> items = bookmarkItemService.findFolders();
            return new Response("Success", 200, items);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }
}
