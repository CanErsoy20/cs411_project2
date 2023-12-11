package com.browser.bookmark.controllers;

import com.browser.bookmark.dtos.AuthRequest;
import com.browser.bookmark.dtos.Response;
import com.browser.bookmark.models.User;
import com.browser.bookmark.services.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("api/user")
public class UserController {

    UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @CrossOrigin(origins = "*")
    @PostMapping("/login")
    public Response login(@RequestBody AuthRequest authRequest) {
        try {
            User user = userService.findUserByEmail(authRequest.getEmail());
            if(!userService.pwMatches(authRequest.getPassword(), user.getPassword())) {
                return new Response("Incorrect email or password.", 406, null);
            }

            return new Response("Login successful.", 200, user);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @PostMapping("/register")
    public Response register(@RequestBody User user) {
        try {
            if(!userService.isValid(user.getPassword())) {
                return new Response("Password must have at least 3 characters.", 406, null);
            }
            if(!isValidEmail(user.getEmail())) {
                return new Response("Please enter a valid email address.", 406, null);
            }

            User createdUser = userService.addUser(user);

            return new Response("Success", 200, createdUser);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/all")
    public Response getAllUsers() {
        try {
            List<User> users = userService.findAllUsers();
            return new Response("Success", 200, users);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/{id}")
    public Response getUserById(@PathVariable("id") long id) {
        try {
            User foundUser = userService.findUserById(id);
            if(foundUser == null)
                return new Response("User does not exist.", 200, null);
            return new Response("Success", 200, foundUser);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping("/get-items/{id}")
    public Response getUserItems(@PathVariable("id") long id) {
        try {
            User foundUser = userService.findUserById(id);
            if(foundUser == null)
                return new Response("User does not exist.", 200, null);
            return new Response("Success", 200, foundUser.getItems());
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @GetMapping
    public Response getUserByEmail(@RequestParam("email") String email) {
        try {
            User foundUser = userService.findUserByEmail(email);
            return new Response("Success", 200, foundUser);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }

    @CrossOrigin(origins = "*")
    @DeleteMapping("/{id}")
    public Response deleteUserById(@PathVariable("id") long id) {
        try {
            userService.deleteUserById(id);
            return new Response("Success", 200, null);
        } catch (Exception e) {
            e.printStackTrace();
            return new Response("Exception", 500, null);
        }
    }
    private boolean isValidEmail(String email) {
        return email.contains("@");
    }
}
