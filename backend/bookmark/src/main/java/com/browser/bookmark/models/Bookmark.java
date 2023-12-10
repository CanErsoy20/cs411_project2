package com.browser.bookmark.models;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@DiscriminatorValue("B")
public class Bookmark extends BookmarkItem {
    private String url;
}
