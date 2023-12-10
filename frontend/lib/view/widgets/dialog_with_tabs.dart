import 'package:cs411_project2/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogWithTabs extends StatefulWidget {
  @override
  _DialogWithTabsState createState() => _DialogWithTabsState();
}

class _DialogWithTabsState extends State<DialogWithTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(controller: _tabController, tabs: const [
                  Tab(text: "Bookmark"),
                  Tab(
                    text: "Folder",
                  )
                ]),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bookmark Name',
                            ),
                            controller: context
                                .read<BookmarksCubit>()
                                .addBookmarkNameController,
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
                                  .addBookmarkURLController,
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
                                  .addBookmarkLabelController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Bookmark label cannot be empty";
                                }
                                return null;
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Folder Name',
                              ),
                              controller: context
                                  .read<BookmarksCubit>()
                                  .addFolderNameController,
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
                                .addFolderLabelController,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          print(_tabController.index);
                        },
                        child: const Text("Add")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
