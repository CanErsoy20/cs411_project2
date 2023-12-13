package com.browser.bookmark.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@DiscriminatorValue("F")
public class Folder extends BookmarkItem {
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "parent_folder_id")
    private List<BookmarkItem> items;

    public Folder(Long id) {
        super(id);
    }
    public Folder(String name) {
        super(name);
    }
    public Folder(Long id, String name) {
        super(id, name);
    }
}
