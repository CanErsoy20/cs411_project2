package com.browser.bookmark;

import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.models.Folder;
import com.browser.bookmark.services.BookmarkService;
import com.browser.bookmark.controllers.BookmarkController;
import com.browser.bookmark.services.FolderService;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import java.util.Collections;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(BookmarkController.class)
@AutoConfigureMockMvc
public class BookmarkControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private BookmarkService bookmarkService;

    @MockBean
    private FolderService folderService;
    @InjectMocks
    private BookmarkController bookmarkController;

    @Test
    public void testAddBookmark() throws Exception {
        Bookmark bookmark = new Bookmark("www.test.com");

        when(bookmarkService.addBookmark(bookmark)).thenReturn(bookmark);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/bookmark/add")
                        .contentType("application/json")
                        .content("{\"name\":\"testname\",\"label\":\"testlabel\",\"user\": {\"user_id\": 1},\"type\":\"B\",\"url\":\"www.test.com\"}"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.url").value("www.test.com"));

        verify(bookmarkService, times(1)).addBookmark(bookmark);
    }

    @Test
    public void testGetAllBookmarks() throws Exception {
        Bookmark bookmark = new Bookmark("www.test.com");
        when(bookmarkService.findAllBookmarks()).thenReturn(Collections.singletonList(bookmark));

        mockMvc.perform(MockMvcRequestBuilders.get("/api/bookmark/all"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data[0].url").value("www.test.com"));

        verify(bookmarkService, times(1)).findAllBookmarks();
    }

    @Test
    public void testGetBookmarkById() throws Exception {
        long bookmarkId = 1L;
        Bookmark bookmark = new Bookmark("www.test.com");
        when(bookmarkService.findBookmarkById(bookmarkId)).thenReturn(bookmark);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/bookmark/{id}", bookmarkId))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.url").value("www.test.com"));

        verify(bookmarkService, times(1)).findBookmarkById(bookmarkId);
    }

    @Test
    public void testDeleteBookmarkById() throws Exception {
        long bookmarkId = 1L;

        mockMvc.perform(MockMvcRequestBuilders.delete("/api/bookmark/{id}", bookmarkId))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200));

        verify(bookmarkService, times(1)).deleteBookmarkById(bookmarkId);
    }

    @Test
    public void testAddBookmarkToFolder() throws Exception {
        long folderId = 1L;
        Folder folder = new Folder(folderId);
        Bookmark bookmark = new Bookmark("http://example.com");

        when(folderService.addFolder(folder)).thenReturn(folder);
        when(bookmarkService.assignBookmarkToFolder(bookmark, folder.getId())).thenReturn(true);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/bookmark/add-to-folder/{id}", folderId)
                        .contentType("application/json")
                        .content("{\"name\":\"testname\",\"label\":\"testlabel\",\"type\":\"B\",\"url\":\"www.test.com\"}"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.url").value("www.test.com"));

        verify(bookmarkService, times(1)).assignBookmarkToFolder(bookmark, folderId);
    }
}

