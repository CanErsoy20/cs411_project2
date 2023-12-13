package com.browser.bookmark.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@DiscriminatorValue("B")
public class Bookmark extends BookmarkItem {
    private String url;
}
