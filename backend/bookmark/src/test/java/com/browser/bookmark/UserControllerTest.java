package com.browser.bookmark;

import com.browser.bookmark.controllers.UserController;
import com.browser.bookmark.dtos.AuthRequest;
import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.Bookmark;
import com.browser.bookmark.models.BookmarkItem;
import com.browser.bookmark.models.User;
import com.browser.bookmark.services.UserService;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@WebMvcTest(UserController.class)
@AutoConfigureMockMvc
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    @InjectMocks
    private UserController userController;

    @Test
    void testLogin() throws Exception {
        AuthRequest authRequest = new AuthRequest("test@example.com", "123");
        User mockUser = new User(1L, "test@example.com", "userpassword", null);

        when(userService.findUserByEmail(authRequest.getEmail())).thenReturn(mockUser);
        when(userService.pwMatches(authRequest.getPassword(), mockUser.getPassword())).thenReturn(true);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/user/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"email\":\"test@example.com\",\"password\":\"123\"}"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Login successful."))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200));
    }

    @Test
    void testRegister() throws Exception {
        User newUser = new User(1L, "new@example.com", "testpw", null);

        when(userService.isValid(newUser.getPassword())).thenReturn(true);
        when(userService.addUser(any(User.class))).thenReturn(newUser);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/user/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"email\":\"new@example.com\",\"password\":\"testpw\"}"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200));
    }

    @Test
    void testGetAllUsers() throws Exception {
        List<User> users = Arrays.asList(new User(1L, "user1@example.com", "hashed1", null), new User(2L, "user2@example.com", "hashed2", null));

        when(userService.findAllUsers()).thenReturn(users);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/user/all"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data").isArray())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data[0].email").value("user1@example.com"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data[1].email").value("user2@example.com"));
    }

    @Test
    void testGetUserById() throws Exception {
        User mockUser = new User(1L, "test@example.com", "userpassword", null);

        when(userService.findUserById(1L)).thenReturn(mockUser);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/user/1"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.email").value("test@example.com"));
    }

    @Test
    void testGetUserItems() throws Exception {
        BookmarkItem bookmark1 = new Bookmark("www.facebook.com");
        BookmarkItem bookmark2 = new Bookmark("www.youtube.com");
        List<BookmarkItem> items = new ArrayList<>();
        items.add(bookmark1);
        items.add(bookmark2);

        User mockUser = new User(1L, "test@example.com", "userpassword", items);

        when(userService.findUserById(1L)).thenReturn(mockUser);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/user/get-items/1"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data").isArray());
    }

    @Test
    void testGetUserByEmail() throws Exception {
        User mockUser = new User(1L, "test@example.com", "userpassword", null);

        when(userService.findUserByEmail("test@example.com")).thenReturn(mockUser);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/user")
                        .param("email", "test@example.com"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200))
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.email").value("test@example.com"));
    }

    @Test
    void testDeleteUserById() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.delete("/api/user/1"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.message").value("Success"))
                .andExpect(MockMvcResultMatchers.jsonPath("$.statusCode").value(200));
    }
}

