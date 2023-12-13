package com.browser.bookmark;

import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.Folder;
import com.browser.bookmark.services.FolderService;
import com.browser.bookmark.controllers.FolderController;
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

@WebMvcTest(FolderController.class)
@AutoConfigureMockMvc
public class FolderControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private FolderService folderService;

    @InjectMocks
    private FolderController folderController;

    @Test
    public void testAddFolder() throws Exception {
        Folder folder = new Folder("Test Folder");

        when(folderService.addFolder(folder)).thenReturn(folder);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/folder/add")
                        .contentType("application/json")
                        .content("{\"name\":\"Test Folder\"}"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.name").value("Test Folder"));

        verify(folderService, times(1)).addFolder(folder);
    }

    @Test
    public void testGetAllFolders() throws Exception {
        Folder folder = new Folder("Test Folder");
        when(folderService.findAllFolders()).thenReturn(Collections.singletonList(folder));

        mockMvc.perform(MockMvcRequestBuilders.get("/api/folder/all"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data[0].name").value("Test Folder"));

        verify(folderService, times(1)).findAllFolders();
    }

    @Test
    public void testGetFolderById() throws Exception {
        long folderId = 1L;
        Folder folder = new Folder(folderId, "Test Folder");
        when(folderService.findFolderById(folderId)).thenReturn(folder);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/folder/{id}", folderId))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.name").value("Test Folder"));

        verify(folderService, times(1)).findFolderById(folderId);
    }

    @Test
    public void testDeleteFolderById() throws Exception {
        long folderId = 1L;

        mockMvc.perform(MockMvcRequestBuilders.delete("/api/folder/{id}", folderId))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200));

        verify(folderService, times(1)).deleteFolderById(folderId);
    }
}

