package com.browser.bookmark;

import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.services.BookmarkItemService;
import com.browser.bookmark.controllers.BookmarkItemController;
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
import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(BookmarkItemController.class)
@AutoConfigureMockMvc
public class BookmarkItemControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private BookmarkItemService bookmarkItemService;

    @InjectMocks
    private BookmarkItemController bookmarkItemController;

    @Test
    public void testAddBookmarkItem() throws Exception {
        BookmarkItem bookmarkItem = new BookmarkItem("Test Name");

        when(bookmarkItemService.addBookmarkItem(bookmarkItem)).thenReturn(bookmarkItem);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/bookmark/item/add")
                        .contentType("application/json")
                        .content("{\"name\":\"Test Name\"}"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.name").value("Test Name"));

        verify(bookmarkItemService, times(1)).addBookmarkItem(bookmarkItem);
    }

    @Test
    public void testGetAllBookmarkItems() throws Exception {
        BookmarkItem bookmarkItem = new BookmarkItem("Test Name");
        when(bookmarkItemService.findAllBookmarkItems()).thenReturn(Collections.singletonList(bookmarkItem));

        mockMvc.perform(MockMvcRequestBuilders.get("/api/bookmark/item/all"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data[0].name").value("Test Name"));

        verify(bookmarkItemService, times(1)).findAllBookmarkItems();
    }

    @Test
    public void testGetBookmarkItemById() throws Exception {
        long bookmarkItemId = 1L;
        BookmarkItem bookmarkItem = new BookmarkItem(bookmarkItemId, "Test Name");
        when(bookmarkItemService.findBookmarkItemById(bookmarkItemId)).thenReturn(bookmarkItem);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/bookmark/item/{id}", bookmarkItemId))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.name").value("Test Name"));

        verify(bookmarkItemService, times(1)).findBookmarkItemById(bookmarkItemId);
    }

    @Test
    public void testDeleteBookmarkItemById() throws Exception {
        long bookmarkItemId = 1L;

        mockMvc.perform(MockMvcRequestBuilders.delete("/api/bookmark/item/{id}", bookmarkItemId))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200));

        verify(bookmarkItemService, times(1)).deleteBookmarkItemById(bookmarkItemId);
    }

    @Test
    public void testGetAllBookmarkItemsByLabel() throws Exception {
        String label = "Test Label";
        List<BookmarkItem> bookmarkItems = Collections.singletonList(new BookmarkItem(label, "http://example.com"));

        when(bookmarkItemService.findBookmarkItemsByLabel(label)).thenReturn(bookmarkItems);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/bookmark/item")
                        .param("label", label))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data[0].label").value("Test Label"));

        verify(bookmarkItemService, times(1)).findBookmarkItemsByLabel(label);
    }

    @Test
    public void testGetLabels() throws Exception {
        long userId = 1L;
        List<String> labels = Collections.singletonList("Label1");

        when(bookmarkItemService.findLabels(userId)).thenReturn(labels);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/bookmark/item/labels/{id}", userId))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data[0]").value("Label1"));

        verify(bookmarkItemService, times(1)).findLabels(userId);
    }
}
