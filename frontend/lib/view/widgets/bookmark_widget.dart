import 'package:cs411_project2/model/bookmark_model.dart';
import 'package:cs411_project2/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/logo_response_model.dart';

class BookmarkWidget extends StatelessWidget {
  const BookmarkWidget({super.key, required this.bookmark});
  final Bookmark bookmark;
  @override
  Widget build(BuildContext context) {
    Image? logo;
    Logos? logos;
    try {
      logos = bookmark.logo?.logos?.firstWhere(
          (element) =>
              (element.type == "symbol" && element.theme == "dark") ||
              (element.type == "icon" && element.theme == "dark") ||
              (element.type == "other"),
          orElse: () => throw Exception());
      if (logos != null) {
        if (logos.formats?.length == 2) {
          logo = Image.network(logos.formats![1].src!, width: 25, height: 25);
        } else {
          logo = Image.network(logos.formats![0].src!, width: 25, height: 25);
        }
      }
    } on Exception catch (e) {
      print(e.toString());
      logo = Image.asset("assets/onlyBrowser.png", width: 25, height: 25);
    }
    if (logos == null) {
      logo = Image.asset("assets/onlyBrowser.png", width: 25, height: 25);
    }

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: InkWell(
            onTap: () {
              context.read<BookmarksCubit>().goWebsite(bookmark.url!);
            },
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
                  logo!,
                  const SizedBox(width: 5),
                  Text(bookmark.name ?? "Error"),
                ],
              ),
            ),
          ),
        ));
  }
}
