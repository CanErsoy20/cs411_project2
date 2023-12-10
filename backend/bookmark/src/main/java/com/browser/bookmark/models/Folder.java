package com.browser.bookmark.models;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
@Data
@Entity
@DiscriminatorValue("F")
public class Folder extends BookmarkItem {
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "parent_folder_id")
    private List<BookmarkItem> items;
}
