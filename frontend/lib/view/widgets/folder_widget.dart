import 'package:cs411_project2/model/bookmark_model.dart';
import 'package:cs411_project2/view/widgets/bookmark_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';

class FolderWidget extends StatelessWidget {
  const FolderWidget(
      {super.key, required this.bookmarks, required this.folderName});
  final List<Bookmark> bookmarks;
  final String folderName;
  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> items = bookmarks
        .map((bookmark) => PopupMenuItem(
              child: BookmarkWidget(bookmark: bookmark),
            ))
        .toList();
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
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bookmark Name',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bookmark URL',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bookmark Label',
                            ),
                          ),
                        ],
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
                              onPressed: () {},
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
                          "Are you sure you want to delete folder \"${folderName}\"?"),
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
                                context.read<BookmarksCubit>().deleteFolder(0);
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
