package com.browser.bookmark.models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Table(name = "bookmark_item")
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "item_type", discriminatorType = DiscriminatorType.STRING)
public class BookmarkItem {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;

    private String label;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;

    private String type;

    public BookmarkItem(Long id) {
        this.id = id;
    }
    public BookmarkItem(String name) {
        this.name = name;
    }
    public BookmarkItem(Long id, String name) {
        this.id = id;
        this.name = name;
    }
    public BookmarkItem(String label, String name) {
        this.label = label;
        this.name = name;
    }
}
