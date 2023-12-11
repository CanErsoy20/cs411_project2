import 'package:cs411_project2/model/bookmark_model.dart';
import 'package:cs411_project2/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkWidget extends StatelessWidget {
  const BookmarkWidget({super.key, required this.bookmark});
  final Bookmark bookmark;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: InkWell(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          "Are you sure you want to delete bookmark \"${bookmark.name}\"?"),
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
                                    .deleteBookmark(bookmark.bookmarkId!);
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
            child: Tooltip(
              message: "Hold to delete bookmark",
              child: Row(
                children: [
                  const Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 5),
                  Text(bookmark.name ?? "Error"),
                ],
              ),
            ),
          ),
        ));
  }
}
