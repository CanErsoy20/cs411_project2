package com.browser.bookmark.repositories;

import com.browser.bookmark.models.BookmarkItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookmarkItemRepository extends JpaRepository<BookmarkItem, Long> {
    @Query("SELECT i FROM BookmarkItem i WHERE i.label=?1")
    List<BookmarkItem> findBookmarkItemsByLabel(String label);
}
