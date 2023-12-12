import 'package:cs411_project2/model/bookmark_item_model.dart';
import 'package:cs411_project2/model/bookmark_model.dart';
import 'package:cs411_project2/view/widgets/bookmark_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'dialog_with_tabs.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget(
      {super.key,
      required this.bookmarks,
      required this.folderName,
      required this.folderId});
  final List<BookmarkItemModel> bookmarks;
  final String folderName;
  final int folderId;

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> assignBookmarkFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> assignFolderFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TabController addTabController = TabController(length: 2, vsync: this);
    List<PopupMenuItem> items = widget.bookmarks
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
                          logo: bookmark.logo,
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
                children: [Icon(Icons.add), Text("Add new bookmark/folder")]),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWithTabs(
                      onPressed: () {
                        if (addTabController.index == 0 &&
                            assignBookmarkFormKey.currentState!.validate()) {
                          context
                              .read<BookmarksCubit>()
                              .assignBookmark(widget.folderId);
                        } else if (addTabController.index == 1 &&
                            assignFolderFormKey.currentState!.validate()) {
                          context
                              .read<BookmarksCubit>()
                              .assignFolder(widget.folderId);
                        }
                      },
                      tabController: addTabController,
                      tabs: const [
                        Tab(text: "Bookmark"),
                        Tab(
                          text: "Folder",
                        )
                      ],
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: assignFolderFormKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Folder Name',
                                      ),
                                      controller: context
                                          .read<BookmarksCubit>()
                                          .assignFolderNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Folder name cannot be empty";
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Folder Label',
                                    ),
                                    controller: context
                                        .read<BookmarksCubit>()
                                        .assignFolderLabelController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Folder label cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                          "Are you sure you want to delete folder \"${widget.folderName}\"?"),
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
                                    .deleteFolder(widget.folderId);
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
              Text(widget.folderName),
            ],
          ),
        ),
      ),
    );
  }
}
