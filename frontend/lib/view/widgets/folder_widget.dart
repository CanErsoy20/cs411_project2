import 'package:cs411_project2/model/bookmark_item_model.dart';
import 'package:cs411_project2/model/bookmark_model.dart';
import 'package:cs411_project2/view/widgets/bookmark_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';

class FolderWidget extends StatelessWidget {
  FolderWidget(
      {super.key,
      required this.bookmarks,
      required this.folderName,
      required this.folderId});
  final List<BookmarkItemModel> bookmarks;
  final GlobalKey<FormState> assignBookmarkFormKey = GlobalKey<FormState>();
  final String folderName;
  final int folderId;
  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> items = bookmarks
        .map((bookmark) => PopupMenuItem(
              child: (bookmark.type! == "F")
                  ? FolderWidget(
                      bookmarks: bookmark.items ?? [],
                      folderName: bookmark.name!,
                      folderId: bookmark.id!,
                    )
                  : BookmarkWidget(
                      bookmark: Bookmark(
                          bookmarkId: bookmark.id,
                          label: bookmark.label,
                          name: bookmark.name,
                          url: bookmark.url)),
            ))
        .toList();
    if (items.isEmpty) {
      items.add(const PopupMenuItem(child: Text("No Bookmark in this Folder")));
    }

    items.add(
      PopupMenuItem(
          value: 3,
          child: TextButton(
            child: const Row(
                children: [Icon(Icons.add), Text("Add New Bookmark")]),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add New Bookmark"),
                      content: Form(
                        key: assignBookmarkFormKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Bookmark Name',
                                ),
                                controller: context
                                    .read<BookmarksCubit>()
                                    .assignBookmarkNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Bookmark name cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Bookmark URL',
                                  ),
                                  controller: context
                                      .read<BookmarksCubit>()
                                      .assignBookmarkURLController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Bookmark URL cannot be empty";
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 10),
                              TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Bookmark Label',
                                  ),
                                  controller: context
                                      .read<BookmarksCubit>()
                                      .assignBookmarkLabelController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Bookmark label cannot be empty";
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                if (assignBookmarkFormKey.currentState!
                                    .validate()) {
                                  context
                                      .read<BookmarksCubit>()
                                      .assignBookmark(folderId);
                                }
                              },
                              child: const Text("Add"),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            },
          )),
    );
    items.add(PopupMenuItem(
        child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          "Are you sure you want to delete folder \"$folderName\"?"),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Nooo, take me back",
                                  style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<BookmarksCubit>()
                                    .deleteFolder(folderId);
                                Navigator.pop(context);
                              },
                              child: const Text("Yes, delete please",
                                  style: TextStyle(color: Colors.green)),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            },
            child: const Row(children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              Text("Delete Folder", style: TextStyle(color: Colors.red)),
            ]))));
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: PopupMenuButton(
        tooltip: "See Bookmarks",
        itemBuilder: (context) => items,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: [
              const Icon(
                Icons.folder,
                color: Colors.grey,
              ),
              const SizedBox(width: 5),
              Text(folderName ?? "Error"),
            ],
          ),
        ),
      ),
    );
  }
}
